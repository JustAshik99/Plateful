//
//  MapListView.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 10/06/2022.
//

import SwiftUI
import MapKit

struct MapListView: View {
    @ObservedObject var annotationCard: RestaurantCardObservable
    @State var restaurants: QueryReturn
    @ObservedObject var locationManager = LocationManager.shared
    @EnvironmentObject var model : MapViewModel
    @State var tracking:MapUserTrackingMode = .follow
    @State var region = MKCoordinateRegion()
    @Environment(\.managedObjectContext) var internalDB
    
    var body: some View {
        
        ZStack{
            Map(coordinateRegion: $region,
                showsUserLocation: true, annotationItems: restaurants.businesses.filter{($0.imageURL != "")}, //select restaurants with an image
                annotationContent: {
                r in
                MapAnnotation(coordinate: .init(latitude: r.coordinates?.latitude ?? 0.0, longitude: r.coordinates?.longitude ?? 0.0)) {//Get Coordinates
                    Annotation(title: r.updatedName, rating: r.upudatedRating) //Assign rating and name for each annotation
                        .shadow(radius: 10)
                        .onTapGesture {
                            
                            withAnimation {
                                annotationCard.restaurant = r //show annotation card of the restaurant
                                self.region = MKCoordinateRegion(center: .init(latitude: r.coordinates?.latitude ?? 0.0, longitude: r.coordinates?.longitude ?? 0.0), span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)) //change region with selected annotation in the center
                            }
                        }
                }
            }
            )
            VStack(spacing: 20){
                Button{
                    YelpRestaurantsAccess().fetchRestaurants(lat: String(region.center.latitude ), long: String(region.center.longitude ), categories: CuisineOptions.all.name) { restaurants in
                        self.restaurants = restaurants //get restaurants of the new region
                    }
                }
            label: {
                Text("Search this area")
                    .frame(width: 170, height: 25)
            }
            .buttonStyle(.borderedProminent)
                Spacer()
            }.padding(.top)
            VStack{
                Spacer()
                ZStack{
                    if (annotationCard.restaurant.id != nil){
                        AnnotationCard(areYouGoingToSecondView: false, restaurant: annotationCard.restaurant)
                    }
                }.padding()
            }
            VStack(alignment:.trailing) {
                VStack{
                    HStack(alignment: .center){
                        Button(action: {
                            withAnimation {self.region = locationManager.userMapRegion} //change region to the users location
                        }) {
                            HStack {
                                Image(systemName: "location").background(Color.white)
                            }
                            .padding()
                            .background(Color.white)
                            .mask(Circle())
                        }.frame(width: 80, height: 80)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    if (annotationCard.restaurant.id != nil){
                        Button(action: {
                            withAnimation {
                                model.favouriteRestaurant(restaurant: annotationCard.restaurant, with: internalDB) //favourite a restaurant
                            }
                        })
                        {
                            HStack {
                                Image(systemName: "star.circle").resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            .background(Color.white)
                            .mask(Circle())
                        }.frame(width: 80, height: 80)
                        Button(action: {
                            withAnimation {
                                annotationCard.restaurant = .init(id: nil, alias: nil, name: "Restaurant", imageURL: "https://s3-media2.fl.yelpcdn.com/bphoto/4HC2FmxHZYzxqlqiRaeKCQ/o.jpg", isClaimed: nil, isClosed: nil, url: nil, phone: nil, displayPhone: nil, reviewCount: nil, categories: nil, rating: 5.0, location: nil, coordinates: nil, photos: nil, price: nil, hours: nil, photosURL: nil, transactions: nil, specialHours: nil, locationAddress1: nil) // assign nil restaurant
                            }
                        })
                        {
                            HStack {
                                Image(systemName: "x.circle").resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            .background(Color.white)
                            .mask(Circle())
                        }.frame(width: 80, height: 80)
                    }
                }
            }
        }
        .onAppear{
            self.region = MKCoordinateRegion(center: .init(latitude: (locationManager.userLocation?.coordinate.latitude)!, longitude: (locationManager.userLocation?.coordinate.longitude)!), span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)) // set region to be users location
            YelpRestaurantsAccess().fetchRestaurants(lat: String(self.locationManager.userLocation?.coordinate.latitude ?? 0.0), long: String(self.locationManager.userLocation?.coordinate.longitude ?? 0.0), categories: CuisineOptions.all.name) { restaurants in
                self.restaurants = restaurants //get restaurants in the users location
            }
        }
        .sheet(item: $model.restaurantSelection, onDismiss: nil) { r in
            MapSingleRestaurantDetail(id: annotationCard.restaurant.id!) // open restaurant details
        }
    }
}

