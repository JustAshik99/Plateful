//
//  Annotation.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 11/06/2022.
//

import SwiftUI

struct Annotation: View {
    let title: String
    let rating: String
      
      var body: some View {
        VStack(spacing: 0) {
          Text("\(title) | \(rating)⭐") // Information on top of annotation
            .font(.callout)
            .padding(5)
            .background(Color(.white))
            .cornerRadius(10)
            
          Image(systemName: "mappin.circle.fill") //circle part of annotation
            .font(.title)
            .foregroundColor(.blue)
          
          Image(systemName: "arrowtriangle.down.fill") //triangle is the bottom part
            .font(.caption)
            .foregroundColor(.blue)
            .offset(x: 0, y: -5)
        }
      }
}
