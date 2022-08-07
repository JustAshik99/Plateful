//
//  FavouriteRestaurants.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 30/05/2022.
//

import Foundation
import Combine
import MapKit
import CoreData
import SwiftUI
import Combine

struct FavouriteRestaurants: View {
    @Environment(\.managedObjectContext) var internalDB
    @FetchRequest(sortDescriptors: []) var favouriteRestaurants: FetchedResults<FavouriteRestaurantModel>
    
    var restaurants: [Business]{
        favouriteRestaurants.map{ //get favourite restaurants and map to a business
            restaurant in Business(id: restaurant.id, alias: nil, name: restaurant.name, imageURL: restaurant.image, isClaimed: nil, isClosed: nil, url: nil, phone: nil, displayPhone: nil, reviewCount: nil, categories: [.init(alias: nil, title: restaurant.cuisine)], rating: Double(restaurant.formattedRating ?? "0"), location: nil, coordinates: .init(latitude: restaurant.latitude, longitude: restaurant.longitude), photos: nil, price: nil, hours: nil, photosURL: nil, transactions: nil, specialHours: nil, locationAddress1: restaurant.formattedAddress)
        }
    }
    
    var body: some View {
        VStack{
            List(restaurants, id: \.id){ restaurant in
                ZStack {
                    NavigationLink(destination: SingleRestaurantDetail2(id: restaurant.id!, restaurant: restaurant)){
                        EmptyView().opacity(0).frame(width: 0) //open restaurant to detail view if selected
                    }
                    RestaurantListCell(restaurant: restaurant)
                }.listRowSeparator(.hidden).swipeActions(edge: .trailing, allowsFullSwipe: true){
                    Button("Delete",role: .destructive){
                        if let restaurant = favouriteRestaurants.first(where: {$0.id == restaurant.id}){ //get the restaurant
                            internalDB.delete(restaurant) //delete
                            do {
                                try internalDB.save() //save
                                print("Saved")
                            } catch {
                                print(error.localizedDescription) //error
                            }
                        }
                    }
                }
            }.listStyle(.plain)
                .navigationTitle("Favourites")
                .safeAreaInset(edge: .bottom){
                    Rectangle().fill(LinearGradient(colors: [.white,.white.opacity(0)], startPoint: .bottom, endPoint: .top)).frame(height: 90) //shadow gradient at the bottom
                }
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

