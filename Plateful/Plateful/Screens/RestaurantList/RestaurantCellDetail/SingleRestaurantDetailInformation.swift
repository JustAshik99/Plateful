//
//  SingleRestaurantDetailInformation.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 10/04/2022.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine

struct SingleRestaurantDetailInformation: View { //Already commented in map folder
    let restaurant : Business
    var body: some View {
        ScrollView{
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
                        let id = restaurant.id!
                        let reviews: [Review] = []
                        NavigationLink(destination: ReviewList(id: id, reviews: reviews)){
                            Text("\u{1F31F}")
                            Text(restaurant.upudatedRating)
                        }
                        Text("💸")
                        Text(returnCash())
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
                        
                        Text("📞")
                        if (restaurant.updatedNumber != ""){
                            Button(action: {openPhone()}){
                                Text(restaurant.updatedNumber)
                            }
                        }
                        else{
                            Text("Unknown")
                        }
                    }
                }.padding(.bottom,15)
                Group{
                    TabView{
                        ForEach(restaurant.updatedImages, id: \.self){
                            imageUrl in AsyncImage.init(url: imageUrl){
                                image in image.resizable().aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.blue
                            }
                        }
                    }
                    .frame(height: 250)
                }
                .cornerRadius(15)
                .tabViewStyle(.page)
            }
        }
        .padding().padding()
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.63)
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
    func returnCash() -> String{
        if (restaurant.updatedPrice == "£££££"){
            return "💲💲💲💲💲"
        }
        else if (restaurant.updatedPrice == "££££"){
            return "💲💲💲💲"
        }
        else if (restaurant.updatedPrice == "£££"){
            return "💲💲💲"
        }
        else if (restaurant.updatedPrice == "££"){
            return "💲💲"
        }
        else if (restaurant.updatedPrice == "£"){
            return "💲"
        }
        else{
            return "Unknown"
        }
    }
}

