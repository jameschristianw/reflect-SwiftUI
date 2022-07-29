//
//  TodaysReflectionComponent.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 26/07/22.
//

import SwiftUI

struct TodaysReflectionComponent: View {
    @EnvironmentObject var menuVM: MenuViewModel
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Today's reflection").font(.headline)
            
//            Text("No relfection for today. Create one to mark your progress.")
//                .font(.subheadline)
//                .padding(.vertical)
            
            Button (action: {
                menuVM.showCreateReflection.toggle()
            }) {
                HStack{
                    Image(systemName: "plus")
                    Text("Create Reflection")
                }
                .frame(minWidth: 0, maxWidth: UIScreen.screenWidth * 0.85)
                .font(.system(size: 18))
                .padding()
                .foregroundColor(.white)
            }
            .background(.black)
            .cornerRadius(8)
        }.padding()
        
    }
}

struct TodaysReflectionComponent_Previews: PreviewProvider {
    static var previews: some View {
        TodaysReflectionComponent()
            .environmentObject(MenuViewModel())
    }
}
