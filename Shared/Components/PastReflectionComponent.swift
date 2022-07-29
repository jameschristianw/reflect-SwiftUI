//
//  PastReflectionComponent.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 26/07/22.
//

import SwiftUI

struct PastReflectionComponent: View {
    @EnvironmentObject var menuVM: MenuViewModel
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdAt, order: .reverse)], predicate: nil) var reflections: FetchedResults<Reflection>
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                HStack{
                    Text("Past reflection").font(.headline)
                    Spacer()
                    Image(systemName: "questionmark.circle").onTapGesture {
                        menuVM.showPastHelp.toggle()
                    }
                }.padding()
                
                if reflections.isEmpty {
                    Text("No past reflection to be shown")
                        .font(.subheadline)
                        .padding()
                } else {
                    ForEach(reflections) { reflection in
                        ReflectionItem(learningNotes: reflection.learningNotes ?? "No Learning Notes", actionPlan: reflection.actionPlan ?? "No Action Plan", challenge: reflection.challenge ?? "No Challenge", category: reflection.category ?? "No Category", url: reflection.url ?? "No URL").padding(.horizontal)
                            
                        Divider()
                    }
                }
            }
        }
        
    }
}

struct PastReflectionComponent_Previews: PreviewProvider {
    static var previews: some View {
        PastReflectionComponent()
            .environmentObject(MenuViewModel())
    }
}
