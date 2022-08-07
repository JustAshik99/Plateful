//
//  SingleRestaurantDetail.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 02/04/2022.
//

import SwiftUI
import MapKit

struct SingleRestaurantDetail: View { //Already commented in map folder
    @EnvironmentObject var model : RestaurantListScreenModel
    @State var region = MKCoordinateRegion()
    let id : String
    let lat: Double
    let long: Double
    var body: some View {
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color.clear)
            let items: [MyAnnotationItem] = [
                MyAnnotationItem(coordinate: .init(latitude: model.restaurant?.coordinates?.latitude ?? 0.0, longitude: model.restaurant?.coordinates?.longitude ?? 0.0)) //Create annotation
            ]
            Map(coordinateRegion: $region,annotationItems: items) { city in MapMarker (coordinate: city.coordinate, tint: .blue)//Create map at the top of screen
            }
            .frame(height: UIScreen.main.bounds.height * 0.40)
        }
        .overlay(
            model.restaurant != nil ?
            SingleRestaurantDetailInformation(restaurant: model.restaurant!) // Add restaurant details underneath
            : nil,
            alignment: .bottom
        )
        .ignoresSafeArea(edges: [.top, .bottom])
        .onAppear{
            model.searchSingleRestaurant(forId: id) //search for restaurant by id
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        }
    }
}



struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}
