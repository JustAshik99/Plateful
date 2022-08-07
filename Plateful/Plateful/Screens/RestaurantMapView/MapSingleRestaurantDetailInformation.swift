//
//  MapSingleRestaurantDetailInformation.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 12/06/2022.
//
import SwiftUI
import CoreLocation
import MapKit
import Combine

struct MapSingleRestaurantDetailInformation: View {
    let restaurant : Business
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading,spacing: 2){
                    Group{
                        Text(restaurant.updatedName).bold().padding(.bottom,8) //Name
                        Text(restaurant.updatedCuisine).padding(.bottom,15) //Cuisine
                    }
                    Group{
                        HStack{
                            Text("📍")
                            Button(action: {openMapWithAddress()}){ //Opens Apple Maps
                                Text(restaurant.updatedAddress)
                            }
                            
                            let reviews: [Review] = []
                            NavigationLink(destination: ReviewList(id: restaurant.id!, reviews: reviews)){ //Links to review screen
                                Text("\u{1F31F}")
                                Text(restaurant.upudatedRating) //restaurant rating obtained from average review rating
                                EmptyView().opacity(0).frame(width: 0)
                            }
                            Text("💸")
                            Text(returnCash()) //price rating
                        }
                    }.padding(.bottom,15)
                    Group{
                        HStack{
                            Text("⏱️")
                            if (restaurant.hours?[0].isOpenNow == true){ //checks if restaurant is currently open
                                Text("Open")
                            }
                            else{
                                Text("Closed")
                            }
                            
                            Text("📞")
                            if (restaurant.updatedNumber != ""){
                                Button(action: {openPhone()}){ //open action sheet to call restaurant
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
                            ForEach(restaurant.updatedImages, id: \.self){ //show images
                                imageUrl in AsyncImage.init(url: imageUrl){
                                    image in image.resizable().aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color.gray //placeholder if image is unavailable
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
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.60)
        }
    }
    
    func openPhone(){
        let number = restaurant.updatedNumber.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "") //remove characters
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

