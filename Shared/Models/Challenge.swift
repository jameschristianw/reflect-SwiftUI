//
//  Challenge.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 28/07/22.
//

import Foundation

struct Challenge: Hashable, Identifiable {
    var name: String
    var id: String
    var color: String
    
    init(name: String, id: String, color: String) {
        self.name = name
        self.id = id
        self.color = color
    }
}
