//
//  ReviewCell.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 09/06/2022.
//

import SwiftUI

struct ReviewCell: View {
    let review : Review
    var body: some View {
        HStack{
            VStack{
                Text(review.user.name).bold().padding(3) //Name
                Text(review.text) // Review
                
                HStack {
                    Text(returnRating()) // rating
                }.padding(3)
            }
        }
        .padding(3)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4) //shadow
    }
    func returnRating()-> String{
        if (review.rating == 5){
            return "⭐⭐⭐⭐⭐"
        }
        else if (review.rating == 4){
            return "⭐⭐⭐⭐"
        }
        else if (review.rating == 3){
            return "⭐⭐⭐"
        }
        else if (review.rating == 2){
            return "⭐⭐"
        }
        else if (review.rating == 1){
            return "⭐"
        }
        else{
            return "Unknown"
        }
    }
}

