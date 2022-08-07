//
//  RestaurantListScreen.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 21/03/2022.
//

import SwiftUI
import CoreData

struct RestaurantListScreen: View { //Shows list of restaurants
    
    @EnvironmentObject var model : RestaurantListScreenModel
    @ObservedObject var locationManager = LocationManager.shared
    @Environment(\.managedObjectContext) var internalDB

    var body: some View {
        
        NavigationView{
            VStack {
                let _: () = locationManager.stopUpdating()
                //Cuisines
                Group{
                    Text("Cusines")
                        .bold()
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach (CuisineOptions.allCases, id: \.self){ c in
                                RestaurantListScreenCuisines(chosenCuisine: $model.selectedCuisine, cuisine: c)
                            } // List of available cuisines
                        }.padding(3)
                    }
                }.padding(.leading,15)
                    .navigationTitle(Text(model.getCityName()))
                // Restaurant list
                List(model.restaurants.filter{($0.imageURL != "")}, id: \.id) //iterate through lists where there is image
                {
                    restaurant in
                    ZStack {
                        NavigationLink(destination: SingleRestaurantDetail(id: restaurant.id!, lat: restaurant.coordinates?.latitude ?? 0.0, long: restaurant.coordinates?.longitude ?? 0.0)) // link to detail view
                        {
                        }
                        if (restaurant.imageURL != ""){
                            RestaurantListCell(restaurant: restaurant) //show restaurant in a cell
                                .padding(3)
                        }
                    }.listRowSeparator(.hidden).swipeActions(edge: .trailing, allowsFullSwipe: true){
                        Button("Favourite"){
                            do {
                                try model.favouriteRestaurant(restaurant: restaurant, with: internalDB) //favourite a restaurant
                                print("Saved")
                            } catch {
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .searchable(text: $model.restaurantSearch, prompt: "Search for a restaurant") //search for a restaurant
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: FavouriteRestaurants()) { // view favourite restaurants
                            Image(systemName: "star")
                        }
                    }
                }
            }
            .onAppear{
                model.selectedCuisine = CuisineOptions.all //refresh screen by selecting all available cuisine
            }
        }
    }
}
