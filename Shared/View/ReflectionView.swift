//
//  ReflectionView.swift
//  Reflect
//
//  Created by James Christian Wira on 26/07/22.
//

import SwiftUI

struct ReflectionView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var reflectionVM: ReflectionViewModel
    @EnvironmentObject var menuVM: MenuViewModel
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                // Today's Reflection
                TodaysReflectionComponent()

                Divider().padding(.horizontal)

                // Past Reflection
                PastReflectionComponent()

                Spacer()
            }
            .navigationTitle("Your Reflection")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MenuView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                    }
                }
            }.sheet(isPresented: $menuVM.showCreateReflection){
                reflectionVM.reset()
            } content: {
                ReflectionFormView()
            }
            .alert("Localise Reflection", isPresented: $menuVM.showPastHelp) {

            } message: {
                Text("Because of limitation of Notion API, past reflection shown here will be from the one you input from this application")
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}

struct ReflectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionView()
            .environmentObject(ReflectionViewModel())
            .environmentObject(MenuViewModel())
    }
}
