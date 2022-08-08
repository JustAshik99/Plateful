//
//  RestaurantListScreenCuisines.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 22/03/2022.
//

import SwiftUI

struct RestaurantListScreenCuisines: View {
    @Binding var chosenCuisine : CuisineOptions
    let cuisine : CuisineOptions
    
    var body: some View {
        Button(action: {chosenCuisine = cuisine}){ //cuisine selected
            HStack{
                Text(cuisine.emoji) //cuisine emoji
                    .font(.title)
                Text(cuisine.name.capitalized(with: nil)) //cuisine name
                    .bold()
            }
        }
        .padding(.horizontal)
        .background(chosenCuisine == cuisine ? .blue : .white) //change background  if true
        .foregroundColor(.black)        
        .cornerRadius(42)
        .padding(.bottom,15)
        .padding(.top,8)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4) //shadow
        
    }
}

