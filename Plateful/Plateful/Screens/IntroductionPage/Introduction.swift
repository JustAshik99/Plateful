//
//  Introduction.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 12/03/2022.
//

import SwiftUI

struct Introduction: View{
    
    @ObservedObject var locationManager = LocationManager.shared
    var image : String //parameters
    var heading : String
    var description : String
    
    @AppStorage("CurrentPage") var currentPage = 1 //Appstorage to store what screen has been completed
    @State private var changeToMap = false
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    Text("Plateful")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .padding()
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(heading)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Text(description)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 125)
            }
            .background(Color(.systemBlue))
        }
        .overlay(
            
            Button(action: {
                withAnimation (.easeInOut){
                    if (currentPage == 3){
                        LocationManager.shared.requestLocation() //request for user location
                    }
                    if (currentPage <= 3){
                        currentPage += 1 //continue with onboarding
                    }
                }}, label:{
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(.white)
                    .clipShape(Circle())
                    .overlay(
                        ZStack{
                            Circle().stroke(Color.black.opacity(0.04),lineWidth: 4)
                            Circle()
                                .trim(from: 0, to:CGFloat(currentPage)/CGFloat(3))
                                .stroke(Color.white,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                        }.padding(-7))
            }).padding(20)
                .padding(.bottom,20)
            ,alignment: .bottom
        )
        
    }
}

