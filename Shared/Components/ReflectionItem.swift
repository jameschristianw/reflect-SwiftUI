//
//  ReflectionItem.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 28/07/22.
//

import SwiftUI

struct ReflectionItem: View {
    var learningNotes: String
    var actionPlan: String
    var challenge: String
    var category: String
    var url: String
    
    var body: some View {
        
        Link(destination: URL(string: url) ?? URL(string: "https://www.google.com")!) {
            VStack(alignment: .leading) {
                Text(learningNotes)
                    .lineLimit(2)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                Text(actionPlan)
                    .lineLimit(1)
                    .font(.body)
                    .padding(.vertical, 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(challenge)
                    .font(.callout)
                    .padding(.vertical, 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(category)
                    .font(.callout)
                    .padding(.vertical, 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
    //            .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.black)
            .background(.white)
    //        .border(.black, width: 5)
    //        .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 1)
            )
        }
        .onTapGesture {
            print(url)
        }
    }
}

struct ReflectionItem_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionItem(learningNotes: "New Learning Notes", actionPlan: "Some Action Plans", challenge: "MC2", category: "Tech", url: "Some URL")
    }
}
