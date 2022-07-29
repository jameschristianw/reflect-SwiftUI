//
//  OnBoadingView.swift
//  Reflect
//
//  Created by James Christian Wira on 26/07/22.
//

import SwiftUI

struct OnBoadingView: View {
    
    @EnvironmentObject var reflectionVM: ReflectionViewModel
    
    @State var isSubmitted: Bool? = nil
    
    @State var showModal: Bool = false
    @State var isLinkEmpty: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Enter your reflection database link from notion to start")
                    .font(.headline)
                
                TextField("Notion Link", text: $reflectionVM.link)
                    .lineLimit(5)
                    .padding()
                    
                Spacer()
                
                NavigationLink(destination: ReflectionView(), tag: true, selection: $isSubmitted) {
                    Button (action: {
                        
                        if reflectionVM.link.count > 0 {
                            let dbId = Helper().getIdFromURL(self.reflectionVM.link)
                            UserDefaults.standard.set(self.reflectionVM.link, forKey: "link")
                            UserDefaults.standard.set(dbId, forKey: "dbID")
                            
                            reflectionVM.dbLink = reflectionVM.link
                            reflectionVM.dbId = dbId
                            reflectionVM.link = ""
                            
                            // Get Reflection Schema
//                            reflectionVM.getDatabase(dbId)
                        }
                        
                        isLinkEmpty.toggle()
                        return
                        
                    }) {
                        Text("Start")
                            .frame(minWidth: 0, maxWidth: UIScreen.screenWidth * 0.85)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.white)
                    }
                }
                .background(.black)
                .cornerRadius(8)
                
                Text("Why can't I skip this step?")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .onTapGesture {
                        showModal.toggle()
                    }
            }
            .alert("This is title", isPresented: $showModal) {
                
            } message: {
                Text("Hello world")
            }
            .alert("Link cannot be empty", isPresented: $isLinkEmpty) {
                
            }
        }
    }
    
}

struct OnBoadingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoadingView().environmentObject(ReflectionViewModel())
    }
}
