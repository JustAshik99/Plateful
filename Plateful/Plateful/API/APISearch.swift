//
//  APISearch.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 22/03/2022.
//

import Foundation
import Combine

final class APISearch: ObservableObject{
    @Published var chosenCuisine = CuisineOptions.all
}
