//
//  MoreInformationCell.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 18/06/2022.
//

import SwiftUI


struct MoreInformationCell: View {

    let headingName: String //parameter
    let description: String
    let systemImage: String
    var body: some View {
        HStack{
            Image(systemName: systemImage)
                .resizable().padding(15)
            .frame(width: 100, height: 100)
            .cornerRadius(20)
            .padding(3)
            
            VStack (alignment: .leading, spacing: 3){
                Text(headingName).bold() //bold heading
                Text(description) //desc
            }
            Spacer()

        }
        .padding(3)
        .background(Color.white)
        .cornerRadius(15) //curved box
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4) //adding a shadow
    }
    
    
}

