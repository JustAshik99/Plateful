//
//  DataController.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 14/06/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "FavouriteRestaurantModel")
    init(){
        container.loadPersistentStores { a, error in
            if let error = error {
                print(error)
            }
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
    }
}
