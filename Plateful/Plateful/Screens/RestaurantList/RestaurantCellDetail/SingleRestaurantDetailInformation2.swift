//
//  SingleRestaurantDetailInformation2.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 08/08/2022.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine

struct SingleRestaurantDetailInformation2: View {
    let restaurant : Business
        var body: some View {
            VStack(alignment: .leading,spacing: 2){
                Group{
                    Text(restaurant.updatedName).bold().padding(.bottom,8)
                    Text(restaurant.updatedCuisine).padding(.bottom,15)
                    
                }
                Group{
                    HStack{
                        Text("📍")
                        Button(action: {openMapWithAddress()}){
                            Text(restaurant.updatedAddress)
                        }
                        
                        Text("\u{1F31F}")
                        Text(restaurant.upudatedRating)
                        Text("💸")
                        Text(restaurant.updatedPrice)
                    }
                }.padding(.bottom,15)
                Group{
                    HStack{
                        Text("⏱️")
                        if (restaurant.hours?[0].isOpenNow == true){
                            Text("Open")
                        }
                        else{
                            Text("Closed")
                        }
                        
                        //Text("Time")
                        Text("📞")
                        Button(action: {openPhone()}){
                            Text(restaurant.updatedNumber)
                        }
                        
                    }
                }.padding(.bottom,15)
                let images = [URL(string: restaurant.imageURL!)]
                Group{
                    TabView{
                        ForEach(images, id: \.self){
                            imageUrl in AsyncImage.init(url: imageUrl){
                                image in image.resizable().aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray
                            }
                        }
                    }
                    .frame(height: 250)
                }
                .cornerRadius(15)
                .tabViewStyle(.page)
            }
            .padding().padding()
            .cornerRadius(20)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.72)
        }
        
        func openPhone(){
            let number = restaurant.updatedNumber.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
            let telephone = "tel://"
            let formattedString = telephone + number
                guard let url = URL(string: formattedString) else { return }
                UIApplication.shared.open(url)
        }
        func openMapWithAddress() {
            let url = URL(string: "maps://?saddr=&daddr=\(restaurant.coordinates!.latitude!),\(restaurant.coordinates!.longitude!)")
            if UIApplication.shared.canOpenURL(url!) {
                  UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
            
        }
    
    
}





