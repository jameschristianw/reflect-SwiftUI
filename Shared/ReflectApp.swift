//
//  ReflectApp.swift
//  Shared
//
//  Created by James Christian Wira on 26/07/22.
//

import SwiftUI

@main
struct ReflectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ReflectionViewModel())
                .environmentObject(MenuViewModel())
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
