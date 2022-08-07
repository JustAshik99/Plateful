//
//  MapViewModel.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 12/06/2022.
//

import Foundation
import Combine
import MapKit
import CoreData
import SwiftUI
import Combine

final class MapViewModel: ObservableObject{
    
    
    @Published var restaurant : Business?
    @Published var mapRegion : MKCoordinateRegion
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
            try FavouriteRestaurantModelContext.save() //favourite a restaurant by saving it
        }
        catch{
            
        }
    }
    
    
    init(){
        
        mapRegion = .init()
        restaurant = nil
        
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
