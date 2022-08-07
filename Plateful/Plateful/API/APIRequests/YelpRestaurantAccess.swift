//
//  YelpRestaurantsAccess.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 12/06/2022.
//

import Foundation
import CoreLocation

public class YelpRestaurantAccess : ObservableObject{
    
    func fetchRestaurants(                          id: String,
                                                    completionHandler: @escaping (Business) -> ()) {
        let apikey = apiKey //apikey
        let baseURL = "https://api.yelp.com/v3/businesses/\(id)" //string interpolation
        let url = URL(string: baseURL)
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization") 
        request.httpMethod = "GET" //type of request
        URLSession.shared.dataTask(with: request) {(data, _, _) in
            if let data = data {
                if let decode = try? JSONDecoder().decode(Business.self, from: data){ //deserialise into object
                    DispatchQueue.main.async {
                        completionHandler(decode)
                    }
                    return
                }
            }
        }.resume()
    }
    
}
