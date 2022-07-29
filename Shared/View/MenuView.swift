//
//  MenuView.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 26/07/22.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    @EnvironmentObject var reflectionVM: ReflectionViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    
    let notificationManager: NotificationManager = NotificationManager.shared
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Section {
                    VStack (alignment: .leading){
                        Text("Notion DB URL")
                            .font(.headline)
                        Text(reflectionVM.dbLink ?? "This is Link")
                    }
                }
                .padding(.vertical)

                Section {
                    VStack (alignment: .leading){
                        Text("Notion DB ID")
                            .font(.headline)
                        Text(reflectionVM.dbId ?? "This is ID")
                    }
                }
                .padding(.vertical)
                
                Section {
                    Toggle(isOn: $menuVM.isReminderSet) {
                        Text("Set Reminder")
                            .font(.headline)
                    }
                    .onChange(of: menuVM.isReminderSet) { newValue in
                        notificationManager.requestAuthorization()
                        
                        print("menuVM isReminderSet \(self.menuVM.isReminderSet)")
                        print("onToggleChange \(newValue)")
                        UserDefaults.standard.set(newValue, forKey: "reminder")
                        menuVM.isReminderSet = newValue
                        
                        if newValue {
                            var dateComponents = DateComponents()
                            dateComponents.hour = 12
                            dateComponents.minute = 30
                            //Reusable method
                            self.notificationManager.scheduleTriggerNotification(title: "It's almost the end of session", body: "Tap me to make today's reflection", categoryIdentifier: "reminder", dateComponents: dateComponents, repeats: true)
                        } else {
                            self.notificationManager.deleteNotifications()
                        }
                    }
                    .padding(.trailing, 4)
                }

                Section {
                    Text("Reset URL Data")
                        .font(.headline)
                        .onTapGesture {
                            menuVM.showResetAlert.toggle()
                        }
                }
                .padding(.vertical)
                
                Section {
                    Text("Reset CoreData Content")
                        .font(.headline)
                        .onTapGesture {
                            menuVM.showResetCDAlert.toggle()
                        }
                }
                .padding(.vertical)

                Section {
                    Text("App Version 1.0")
                        .font(.headline)
                }
                .padding(.vertical)

                Spacer()
            }
        }
        .padding()
        .navigationTitle("Settings")
        .alert("Reset All Data?", isPresented: $menuVM.showResetAlert) {
            Button("Cancel", role: .cancel) {
            }
            Button("Ok") {
                UserDefaults.standard.set(nil, forKey: "link")
                reflectionVM.dbLink = nil
            }
        }
        .alert("Reset CoreData Content?", isPresented: $menuVM.showResetCDAlert){
            Button("Cancel", role: .cancel) {
            }
            Button("Ok") {
                ReflectionCD().deleteAllData(moc: moc)
            }
        }
        
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(ReflectionViewModel())
            .environmentObject(MenuViewModel())
    }
}
