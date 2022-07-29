//
//  ReflectionCD.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 28/07/22.
//

import Foundation
import CoreData
import SwiftUI

struct ReflectionCD {
    
    func deleteAllData(moc: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Reflection")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try moc.save()
            try moc.execute(deleteRequest)
            moc.reset()
        } catch _ as NSError {
            // TODO: handle the error
        }
    }
}
