//
//  RestaurantCardObservable.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 11/06/2022.
//

import Foundation

class RestaurantCardObservable: ObservableObject{
    
    @Published var restaurant: Business = .init(id: nil, alias: nil, name: nil, imageURL: nil, isClaimed: nil, isClosed: nil, url: nil, phone: nil, displayPhone: nil, reviewCount: nil, categories: nil, rating: nil, location: nil, coordinates: nil, photos: nil, price: nil, hours: nil, photosURL: nil, transactions: nil, specialHours: nil, locationAddress1: nil)
    
    @Published var card = AnnotationCard(areYouGoingToSecondView: false, restaurant: .init(id: nil, alias: nil, name: nil, imageURL: nil, isClaimed: nil, isClosed: nil, url: nil, phone: nil, displayPhone: nil, reviewCount: nil, categories: nil, rating: nil, location: nil, coordinates: nil, photos: nil, price: nil, hours: nil, photosURL: nil, transactions: nil, specialHours: nil, locationAddress1: nil))
}
