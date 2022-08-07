//
//  CuisineOptions.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 09/06/2022.
//
import Foundation

enum CuisineOptions: CaseIterable {
    case all,japanese,chinese,indian,american,breakfast

    var emoji: String {
        switch self {
        case .all:
            return "🍲"
        case .japanese:
            return "🍣"
        case .chinese:
            return "🍜"
        case .indian:
            return "🍛"
        case .american:
            return "🍔"
        case .breakfast:
            return "🥐"
        }
    }

    var name: String {
        switch self {
        case .all:
            return "all"
        case .japanese:
            return "japanese"
        case .chinese:
            return "chinese"
        case .indian:
            return "indian"
        case .american:
            return "american"
        case .breakfast:
            return "breakfast"
        }
    }
}
