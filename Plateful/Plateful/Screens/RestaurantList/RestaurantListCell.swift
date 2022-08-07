//
//  RestaurantListCell.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 28/03/2022.
//

import SwiftUI


struct RestaurantListCell: View {
    
    let restaurant : Business
    
    var body: some View {
        HStack{
            AsyncImage(url: restaurant.updatedImageUrl) { image in //show image
                image.resizable()
            } placeholder: {
                Color.blue
            }
            .frame(width: 100, height: 100)
            .cornerRadius(20)
            .padding(3)
            
            VStack (alignment: .leading, spacing: 3){
                Text(restaurant.updatedName).bold() //Name
                Text(restaurant.updatedCuisine) //cuisine
                HStack {
                    Text(returnRating())
                }
            }
            Spacer()
        }
        .padding(3)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4) //shadow
    }
    func returnRating()-> String{ //return rating emoji
        if (restaurant.rating == 5){
            return "⭐⭐⭐⭐⭐"
        }
        else if (restaurant.rating == 4 || restaurant.rating == 4.5){
            return "⭐⭐⭐⭐"
        }
        else if (restaurant.rating == 3 || restaurant.rating == 3.5){
            return "⭐⭐⭐"
        }
        else if (restaurant.rating == 2 || restaurant.rating == 2.5){
            return "⭐⭐"
        }
        else if (restaurant.rating == 1 || restaurant.rating == 1.5){
            return "⭐"
        }
        else{
            return "Unknown"
        }
    }
}
