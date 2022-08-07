//
//  ReviewList.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 07/06/2022.
//

import SwiftUI
import CDYelpFusionKit

struct ReviewList: View {
    var id: String
    @State var reviews: [Review]
    var body: some View {
        VStack{
            List{
                ForEach(reviews, id: \.text) { r in //List of reviews
                    ReviewCell(review: r) //the cell takes in a parameter of review
                        .padding(3)
                }
            }
            .listStyle(.plain)
            .safeAreaInset(edge: .bottom){
                Rectangle().fill(LinearGradient(colors: [.white,.white.opacity(0)], startPoint: .bottom, endPoint: .top)).frame(height: 90)
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                YelpReviewAccess().fetchReviews(id: id) { (r) in // get reviews for restaurant by id
                    self.reviews = r.reviews
                }
            }
            .navigationTitle("Reviews")
        } 
    }
}



