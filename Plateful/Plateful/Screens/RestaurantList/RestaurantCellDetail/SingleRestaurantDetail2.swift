//
//  SingleRestaurantDetail2.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 05/06/2022.
//

import SwiftUI
import MapKit

struct SingleRestaurantDetail2: View { //Already commented in map folder
    let id: String
    @State var restaurant : Business
    var body: some View {
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color.clear)
            let items: [MyAnnotationItem] = [
                MyAnnotationItem(coordinate: .init(latitude: restaurant.coordinates?.latitude ?? 0.0, longitude: restaurant.coordinates?.longitude ?? 0.0))
            ]
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: restaurant.coordinates?.latitude ?? 0, longitude: restaurant.coordinates?.longitude ?? 0), span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001))),annotationItems: items) { city in MapMarker (coordinate: city.coordinate, tint: .blue)
            }
            .frame(height: UIScreen.main.bounds.height * 0.40)
        }
        .onAppear{
            YelpRestaurantAccess().fetchRestaurants(id: id) { r in
                self.restaurant = r
            }
        }
        .overlay(
            SingleRestaurantDetailInformation2(restaurant: restaurant),
            alignment: .bottom
        )
        .ignoresSafeArea(edges: [.top, .bottom])
    }
}


