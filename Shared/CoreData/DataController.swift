//
//  DataController.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 28/07/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Reflection")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print ("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
