//
//  AnnotationCard.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 11/06/2022.
//

import SwiftUI

struct AnnotationCard: View {
    @EnvironmentObject var model : MapViewModel
    @State var areYouGoingToSecondView: Bool
    let restaurant: Business
    
    var body: some View {
        HStack{
            VStack(alignment: .leading,spacing: 15 ){
                restaurantSelection
                title
            }
            VStack(spacing: 20){
                Button{
                    model.restaurantSelection = restaurant //assign restaurant
                }
            label: {
                Text("Expand")
                    .frame(width: 170, height: 25)
            }
            .buttonStyle(.borderedProminent)
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial).offset(y: 60)).clipped()
        
        
        
    }
}

extension AnnotationCard{
    private var restaurantSelection: some View{
        ZStack{
            AsyncImage(url: restaurant.updatedImageUrl) { image in
                image.resizable()
                    .cornerRadius(10)
            } placeholder: {
                Color.blue
            }
        } //restaurant image on the card
        .frame(width: 100, height: 100)
        .padding(3)
        .background(.blue)
        .cornerRadius(10)
    }
    private var title: some View{
        VStack(alignment: .leading, spacing: 4){
            Text(restaurant.updatedName) //title
                .bold()
            Text(restaurant.updatedCuisine) //cuisine
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

