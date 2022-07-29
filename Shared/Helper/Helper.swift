//
//  Helper.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 27/07/22.
//

import Foundation

struct Helper {
    func getIdFromURL(_ url: String) -> String {
        let parsedUrl = URL(string: url)!
        
        var dbId = parsedUrl.path
        dbId.remove(at: dbId.startIndex)
        
        return dbId
    }
    
}
