//
//  RestaurantListScreenModel.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 26/03/2022.
//

import Foundation
import Combine
import MapKit
import CoreData
import SwiftUI
import Combine

final class RestaurantListScreenModel: ObservableObject{
    
    
    @Published var restaurants = [Business]()
    @Published var restaurant : Business?
    @Published var restaurantSearch = ""
    @Published var selectedCuisine = CuisineOptions.all
    @Published var mapRegion : MKCoordinateRegion
    @Published var cityName = ""
    @ObservedObject var locationManager = LocationManager.shared
    @Published var restaurantSelection: Business? = nil
    
    var disposals = [AnyCancellable]()
    
    func favouriteRestaurant(restaurant: Business, with FavouriteRestaurantModelContext: NSManagedObjectContext){
        let favouritedRestaurant = FavouriteRestaurantModel(context: FavouriteRestaurantModelContext)
        
        favouritedRestaurant.id = restaurant.id
        favouritedRestaurant.image = restaurant.imageURL
        favouritedRestaurant.cuisine = restaurant.updatedCuisine
        favouritedRestaurant.name = restaurant.updatedName
        favouritedRestaurant.formattedAddress = restaurant.location?.address1
        favouritedRestaurant.formattedNumber = restaurant.updatedNumber
        favouritedRestaurant.rating = restaurant.upudatedRating
        favouritedRestaurant.longitude = restaurant.coordinates?.longitude ?? 0
        favouritedRestaurant.latitude = restaurant.coordinates?.latitude ?? 0
        favouritedRestaurant.formattedPrice = restaurant.updatedPrice
        favouritedRestaurant.formattedRating = restaurant.upudatedRating
        
        do{
            try FavouriteRestaurantModelContext.save() //save restaurant
        }
        catch{
            //ignore any errors
        }
    }
    
    init(){
        
        restaurantSearch = ""
        selectedCuisine = .all
        mapRegion = .init()
        restaurant = nil
        search()
        
    }
    
    func search(service: YelpAccess = .access){
        
        $restaurantSearch
            .combineLatest($selectedCuisine)
            .flatMap{ (query,cat) in
                service.getAllRestaurants(.getAllRestaurants(term: "halal restaurant \(query)", location: .init(latitude: self.locationManager.userLocation?.coordinate.latitude ?? 51.500972, longitude: self.locationManager.userLocation?.coordinate.longitude ?? -0.125313), category: query.isEmpty ? cat : nil)) //creating a search query with a query and location data
            }
            .assign(to: &$restaurants)
        
    }
    func getCityName() -> String{
        locationManager.getPlace(for: locationManager.userLocation!) { placemark in
            guard let placemark = placemark else { return }

            self.cityName = placemark.locality! //get name of area
        }
        return self.cityName
    }
    func searchSingleRestaurant(forId id : String, service: YelpAccess = .access){
        service.getDetails(.getDetails(id: id))
            .sink { _ in
                
            } receiveValue: { [weak self] restaurant in
                let coords = CLLocationCoordinate2D(latitude: restaurant?.coordinates?.latitude ?? 0, longitude: restaurant?.coordinates?.longitude ?? 0)
                let region = MKCoordinateRegion(center: coords, span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001))
                
                self?.restaurant = restaurant
                self?.mapRegion = region
            }.store(in: &disposals)
    
        
    }

}
