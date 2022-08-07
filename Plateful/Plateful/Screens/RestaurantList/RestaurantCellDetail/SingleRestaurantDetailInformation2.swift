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

struct SingleRestaurantDetailInformation: View {
    let restaurant : Business
    var body: some View {
        VStack(alignment: .leading,spacing: 2){
            Group{
                Text(restaurant.formattedName).bold().padding(.bottom,.medium)
                Text(restaurant.formattedName).padding(.bottom,.large)
                
            }
            Group{
                HStack{
                    Image(systemName: "map")
                    Button(action: {openMapWithAddress()}){
                        Text(restaurant.formattedAddress)
                    }
                    
                    Image(systemName: "star")
                    Text(restaurant.formattedRating)
                    Image(systemName: "plus")
                    Text(restaurant.formattedPrice)
                }
            }.padding(.bottom,.large)
            Group{
                HStack{
                    Image(systemName: "stopwatch")
                    if (restaurant.hours?[0].isOpenNow == true){
                        Text("Open")
                    }
                    else{
                        Text("Closed")
                    }
                    
                    //Text("Time")
                    Image(systemName: "phone")
                    Button(action: {openPhone()}){
                        Text(restaurant.formattedNumber)
                    }
                    
                }                
            }.padding(.bottom,.large)
            Group{
                TabView{
                    ForEach(restaurant.formattedImages, id: \.self){
                        imageUrl in AsyncImage.init(url: imageUrl){
                            image in image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray
                        }
                    }
                }
                .frame(height: 250)
            }
            .cornerRadius(.large)
            .tabViewStyle(.page)
        }
        .padding().padding()
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)
    }
    
    func openPhone(){
        let number = restaurant.formattedNumber.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
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

struct SingleRestaurantDetailInformation_Previews: PreviewProvider {
    static var previews: some View {
        SingleRestaurantDetailInformation(restaurant: .init(id: nil, alias: nil, name: "Restaurant", imageURL: "https://s3-media2.fl.yelpcdn.com/bphoto/4HC2FmxHZYzxqlqiRaeKCQ/o.jpg", isClaimed: nil, isClosed: nil, url: nil, phone: nil, displayPhone: "07344568305", reviewCount: nil, categories: nil, rating: 5.0, location: .init(address1: nil, address2: nil, address3: nil, city: nil, zipCode: nil, country: nil, state: nil, displayAddress: ["Test"], crossStreets: nil), coordinates: nil, photos: ["https://s3-media2.fl.yelpcdn.com/bphoto/4HC2FmxHZYzxqlqiRaeKCQ/o.jpg","https://s3-media2.fl.yelpcdn.com/bphoto/4HC2FmxHZYzxqlqiRaeKCQ/o.jpg"], price: "$$", hours: nil, transactions: nil, specialHours: nil))
    }
}
