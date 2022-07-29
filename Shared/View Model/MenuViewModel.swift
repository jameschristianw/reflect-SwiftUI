//
//  MenuViewModel.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 26/07/22.
//

import Foundation

class MenuViewModel: ObservableObject {
    @Published var showCreateReflection: Bool = false
    @Published var showPastHelp: Bool = false
    @Published var showMenu: Bool = false
    @Published var showResetAlert: Bool = false
    @Published var showResetCDAlert: Bool = false
    @Published var isReminderSet: Bool = UserDefaults.standard.bool(forKey: "reminder") 
}
