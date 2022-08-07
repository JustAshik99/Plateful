//
//  YelpAccess.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 26/03/2022.
//

import Foundation
import CoreLocation
import Combine

let apiKey = "bwOO6N3sxWtvNEVuRY6Y5-FCkvldzPsb7BQNLsOxIrS96UHxH82f6jLZSMa01uz_cbrUDUk5uJFcJPMawsdlK7HSKn6Wh3Y6TGjEcQ5DuLX_ULWsihgP14mo2U_kYnYx"

struct YelpAccess {
    //Yelp API access for the model
    var getAllRestaurants: (Endpoint) -> AnyPublisher<[Business], Never> //request for list of businesses
    var getDetails: (Endpoint) -> AnyPublisher<Business?, Never> //request for business details
}

extension YelpAccess {
    static let access = YelpAccess(
        getAllRestaurants: { endpoint in
            return URLSession.shared.dataTaskPublisher(for: endpoint.request)
                .tryMap(\.data)
                .decode(type: QueryReturn.self, decoder: JSONDecoder()) //deserialise
                .map(\.businesses) //map to list of busineeses
                .replaceError(with: [])//if theres an error deserialising return empty array
                .receive(on: DispatchQueue.main)
                .print("recieved")
                .eraseToAnyPublisher()
        },
        getDetails: { endpoint in
            // URL request and return Businesses
            return URLSession.shared.dataTaskPublisher(for: endpoint.request)
                .tryMap(\.data)
                .decode(type: Business?.self, decoder: JSONDecoder())//deserialise to object
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main) //get on main thread
                .print("recieved")
                .eraseToAnyPublisher() //return
        }
    )
}

enum Endpoint {
    case getAllRestaurants(term: String?, location: CLLocation, category: CuisineOptions?)
    case getDetails(id: String)

    var path: String {
        switch self {
        case .getAllRestaurants:
            return "/v3/businesses/search"
        case .getDetails(let id):
            return "/v3/businesses/\(id)"
        }
    }

    var URLqueryItems: [URLQueryItem] {
        switch self {
        case .getAllRestaurants(let term, let location, let category): //assign parameters
            return [
                .init(name: "term", value: term), // query nam (halal restaurants + abc)
                .init(name: "categories", value: category?.name ?? CuisineOptions.all.name), //cuisines
                .init(name: "longitude", value: String(location.coordinate.longitude)),
                .init(name: "latitude", value: String(location.coordinate.latitude)),
            ]
        case .getDetails:
            return [] // no param
        }
    }

    var request: URLRequest {
        let rootAddress = "https://api.yelp.com"
        var urlComponents = URLComponents(string: rootAddress)!
        urlComponents.path = path // root + abc
        urlComponents.queryItems = URLqueryItems //parameters
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization") //api auth
        return request
    }

}

struct QueryReturn: Codable{
    let businesses: [Business]
}
