//
//  ReflectionFormView.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 26/07/22.
//

import SwiftUI
import Foundation

struct ReflectionFormView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    @EnvironmentObject var reflectionVM: ReflectionViewModel
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    let categories: [String] = ["Tech", "Design", "Product", "Business", "Peer Feedback", "Goals Evaluation", "Challenge Relfections"]
    let challenge: [String] = ["🏁 First Week", ""]
    
    enum FocusField: Hashable {
        case learningNotes, actionPlan
    }

    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        ScrollView{
            
            VStack (alignment: .leading){
                HStack {
                    Button("Cancel") {
                        menuVM.showCreateReflection.toggle()
                    }.disabled(reflectionVM.isSendingReflection)
                    
                    Spacer()
                    
                    Text("Create Reflection")
                        .font(.title3)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            await reflectionVM.sendReflection(context: moc, presentation: presentation)
                        }
                    } label: {
                        if (reflectionVM.isSendingReflection) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            Text("Send")
                        }
                    }
                }
                
                Text("Write your quick reflection for today here. Reflection sent from here will update your table in Notion")
                    .font(.subheadline)
                    .padding(.vertical)
            
                Section {
                    Text("Learning Notes")
                    
                    ZStack (alignment: .leading){
                        TextEditor(text: $reflectionVM.learningNotes)
                            .focused($focusedField, equals: .learningNotes)
                        if reflectionVM.learningNotes.isEmpty {
                            Text("Explain briefly your learnings today")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                                .onTapGesture {
                                    self.focusedField = .learningNotes
                                }
                        }
                    }
                }
                
                Section {
                    Text("Action Plan")
                    
                    ZStack (alignment: .leading){
                        TextEditor(text: $reflectionVM.actionPlan)
                            .focused($focusedField, equals: .actionPlan)
                        if reflectionVM.actionPlan.isEmpty {
                            Text("Explain your action plan")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                                .onTapGesture {
                                    self.focusedField = .actionPlan
                                }
                        }
                    }
                }
                
                HStack{
                    Text("Category")
                    Spacer()
                    Picker("Category", selection: $reflectionVM.category) {
                        ForEach(reflectionVM.categoryList) { category in
                            Text(category.name).foregroundColor(.black).tag(category)
                        }
                    }.id(reflectionVM.categoryList)
                }.padding(.vertical)
                
                HStack{
                    Text("Challenge")
                    Spacer()
                    Picker("Challenge", selection: $reflectionVM.challenge) {
                        ForEach(reflectionVM.challengeList.reversed()) { challenge in
                            Text(challenge.name).foregroundColor(.black).tag(challenge)
                        }
                    }
                }.padding(.vertical)
                
                Spacer()
            }.padding()
        }
        .interactiveDismissDisabled()
        .alert("Learning notes empty", isPresented: $reflectionVM.isLearningNoteEmpty) {
            
        }
    }
}

struct ReflectionFormView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionFormView()
            .environmentObject(MenuViewModel())
    }
}
