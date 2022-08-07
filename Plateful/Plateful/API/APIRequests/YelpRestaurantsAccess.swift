//
//  YelpRestaurantsAccess.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 12/06/2022.
//

import Foundation
import CoreLocation

public class YelpRestaurantsAccess : ObservableObject{
    
    func fetchRestaurants(                          lat: String,
                                                    long: String,
                                                    categories: String,
                                                    completionHandler: @escaping (QueryReturn) -> ()) {
        let apikey = apiKey //yelp api key
        let baseURL = "https://api.yelp.com/v3/businesses/search?term=halal%20restaurant&longitude=\(long)&latitude=\(lat)&categories=all" //url with parameters
        let url = URL(string: baseURL)
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization") //auth
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {(data, _, _) in
            if let data = data {
                if let decode = try? JSONDecoder().decode(QueryReturn.self, from: data){ //deserialise into object
                    DispatchQueue.main.async {
                        completionHandler(decode)
                    }
                    return
                }
            }
        }.resume()
    }
    
}
