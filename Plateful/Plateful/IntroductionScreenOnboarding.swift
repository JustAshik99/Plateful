//
//  ContentView.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 26/02/2022.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager.shared //checking if location permission has been shared
    @AppStorage("CurrentPage") var currentPage = 1
    @StateObject private var dataController = DataController()
    var body: some View {
        
        if locationManager.userLocation == nil{
            if currentPage == 1{ //onboarding screens until permission is given
                Introduction(image: "Intro1",heading: "Halal Restaurants",description: "Get halal restaurants near you, find an array of different restaurants that suit your taste buds")
            }
            if currentPage == 2{
                Introduction(image: "Intro2",heading: "Cuisines",description: "Lots of cuisine selection. From Japanese to American, choose whatever restaurant you're feeling")
            }
            if currentPage == 3{
                Introduction(image: "Intro3",heading: "Location",description: "Your location is required to find the restaurants near you")
            }
            if currentPage == 4{
                Introduction(image: "EnableLocation",heading: "Location permission",description: "Enable location settings for Plateful in iOS settings to use the app")
            }

        }
        else{
            TabView{ // A group of items in the tab bar
                let model = RestaurantListScreenModel() //Restaurant list view
                RestaurantListScreen()
                    .environmentObject(model)// model view object
                    .preferredColorScheme(.light) //default light colour scheme
                    .environment(\.managedObjectContext, dataController.container.viewContext) //passing the internalDB as an environment object
                    .tabItem{
                        Label("Restaurants", systemImage: "heart.text.square")
                    }
                
                
                let mapModel = MapViewModel() // Map view
                MapListView(annotationCard: .init(), restaurants: .init(businesses: .init()))
                    .environmentObject(mapModel)
                    .preferredColorScheme(.light)
                    .environment(\.managedObjectContext, dataController.container.viewContext)//passing the internalDB as an environment object
                    .tabItem{
                        Label("Map", systemImage: "mappin.square")
                    }
                
                MoreScreenMain().tabItem{ //More information screen
                    Label("More", systemImage: "ellipsis.circle.fill")
                }

            }
            
            
        }
        

    }
}

struct Home: View{
    var body: some View{
        Text("")
    }
}




