//
//  Reviews.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 09/06/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let id: String?
    let reviews: [Review]
    let total: Int
    let possibleLanguages: [String]

    enum CodingKeys: String, CodingKey {
        case reviews, total, id
        case possibleLanguages = "possible_languages"
    }
}

// MARK: - Review
struct Review: Codable {
    let id: String
    let rating: Int
    let user: User
    var text, timeCreated: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, rating, user, text
        case timeCreated = "time_created"
        case url
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let profileURL: String
    let imageURL: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case profileURL = "profile_url"
        case imageURL = "image_url"
        case name
    }
}
