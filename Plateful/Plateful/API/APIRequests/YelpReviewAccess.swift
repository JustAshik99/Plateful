//
//  YelpReviewAccess.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 08/06/2022.
//

import Foundation
import CDYelpFusionKit

public class YelpReviewAccess : ObservableObject{
    
    func fetchReviews(id: String,
                      completionHandler: @escaping (Welcome) -> ()) {
        let apikey = apiKey
        let baseURL = "https://api.yelp.com/v3/businesses/\(id)/reviews"
        let url = URL(string: baseURL)
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {(data, _, _) in
                    let reviews = try! JSONDecoder().decode(Welcome.self, from: data!)
                    DispatchQueue.main.async {
                        completionHandler(reviews)
                    }
                }.resume()
    }
}


