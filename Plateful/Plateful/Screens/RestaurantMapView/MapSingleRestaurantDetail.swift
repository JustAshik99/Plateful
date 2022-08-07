//
//  MapSingleRestaurantDetail.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 12/06/2022.
//

import SwiftUI
import MapKit

struct MapSingleRestaurantDetail: View {
    @EnvironmentObject var model : MapViewModel
    
    let id : String
    var body: some View {
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color.clear)
            let _: () = model.locationManager.stopUpdating()
            let items: [MyAnnotationItem] = [
                MyAnnotationItem(coordinate: .init(latitude: model.restaurant?.coordinates?.latitude ?? 0.0, longitude: model.restaurant?.coordinates?.longitude ?? 0.0)) // Annotation
            ]
            Map(coordinateRegion: $model.mapRegion,annotationItems: items) { city in MapMarker (coordinate: city.coordinate, tint: .blue) //Create map at the top of screen
            }
            .frame(height: UIScreen.main.bounds.height * 0.33)
        }
        .overlay(
            model.restaurant != nil ?
            SingleRestaurantDetailInformation(restaurant: model.restaurant!) // Add restaurant details underneath
            : nil,
            alignment: .bottom
        )
        .ignoresSafeArea(edges: [.top, .bottom])
        .onAppear{
            model.searchSingleRestaurant(forId: id) //request for restaurant details by id
        }
    }
}

