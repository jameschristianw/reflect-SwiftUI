//
//  ReflectionViewModel.swift
//  Reflect
//
//  Created by James Christian Wira on 26/07/22.
//

import Foundation
import CoreData
import SwiftUI

class ReflectionViewModel: ObservableObject {
    @Published var dbLink = UserDefaults.standard.string(forKey: "link")
    @Published var dbId = UserDefaults.standard.string(forKey: "dbID")
    
    @Published var link: String = ""
    @Published var isLinkSubmitted: Bool = false
    
    @Published var learningNotes: String = ""
    @Published var actionPlan: String = ""
    @Published var category: Category = Category(name: "Tech", id: "233466d5-2b42-43d6-b5c3-0b3b79a00be1", color: "blue")
    @Published var challenge: Challenge = Challenge(name: "🏁 First Week", id: "3d783b44-9799-450a-87a8-9243339b810e", color: "purple")
    
    @Published var isLearningNoteEmpty = false
    @Published var isSendingReflection = false
    @Published var isSent = false
    
    
    @Published var categoryList: [Category] = [
        Category(name: "Tech", id: "233466d5-2b42-43d6-b5c3-0b3b79a00be1", color: "blue"),
        Category(name: "Design", id: "9f4d5b66-6d4b-45c3-91e4-731e295dbe23", color: "yellow"),
        Category(name: "Professional Growth", id: "5a016649-d2ae-4768-984d-549410f92a92", color: "red"),
        Category(name: "Product", id: "c12810d8-0340-42fa-a29d-e8b9ba472ac0", color: "default"),
        Category(name: "Business", id: "6ec39312-a847-4ee1-a5f5-b8bac0d2f982", color: "gray"),
        Category(name: "Peer Feedback", id: "033d79c9-7ce9-47c7-b213-a0e348fd2993", color: "brown"),
        Category(name: "Goals Evaluation", id: "3b04f925-bc5e-4108-bccb-1be3c30d31cb", color: "purple"),
        Category(name: "Challenge Relfections", id: "fbd35c0f-1fda-4f59-9029-4eabd854586b", color: "orange")
    ]
    @Published var challengeList: [Challenge] = [
        Challenge(name: "🏁 First Week", id: "3d783b44-9799-450a-87a8-9243339b810e", color: "purple"),
        Challenge(name: "🏃🏻‍♀️ Mini Challenge 1", id: "ca948d49-5ef9-4d93-be3b-ad2ddf567a65", color: "yellow"),
        Challenge(name: "🌁 Bridge 1", id: "e427edb1-f192-41b9-8b4c-c5a6437cacb8", color: "pink"),
        Challenge(name: "🍬 Nano Challenge 1", id: "b12fb475-72ae-4ce9-8cdf-36df027b4d30", color: "blue"),
        Challenge(name: "🍡 Bridge 2", id: "b8cdc538-14b5-40a2-9fe8-a51c376b5f3a", color: "pink"),
        Challenge(name: "⚡️ Mini Challenge 2", id: "53b537d4-c3a9-490f-b68a-38948a64887d", color: "yellow"),
        Challenge(name: "🍧 Bridge 3", id: "5ccd7fc7-796c-4ead-b8b6-10ab5acd7bf2", color: "pink"),
        Challenge(name: "🔋 Nano Challenge 2", id: "b2b57b62-de45-4b7c-af7f-6370d9ef4560", color: "blue"),
        Challenge(name: "🎂 Bridge 4", id: "b946a6d7-662a-4711-9e4d-448fb0de9ad0", color: "pink"),
        Challenge(name: "🏆 Macro Challenge", id: "b32af259-6103-41a3-9920-e1e511f16f78", color: "orange"),
        Challenge(name: "🍕 Bridge 5", id: "feef78df-e0ce-4936-b39d-5f08d9cc9032", color: "pink"),
        Challenge(name: "🌌 Nano Challenge 3", id: "d934adec-ef8b-49ce-a7bd-6528aa85e512", color: "blue")
    ]
    
    @Published var editItem: Reflection!
    
    func getDatabase(_ id: String) {
//        let url = "databases/\(id)"
        
//        callApi(url: url, method: "GET")
    }
    
    @MainActor
    func sendReflection(context: NSManagedObjectContext, presentation: Binding<PresentationMode>) async {
        isSendingReflection = true
        
        print("Learning notes : \(learningNotes)")
        print("Action plan    : \(actionPlan)")
        print("Category       : \(category.name) \(category.id)")
        print("Challenge      : \(challenge.name) \(challenge.id)")
        
        if learningNotes.isEmpty {
            isLearningNoteEmpty = true
            return
        }
        
        let body: [String: Any] = [
            "parent": [
                "database_id": dbId
            ],
            "properties": [
                "Learning Notes": [
                    "title": [
                        [
                            "text": [
                                "content": learningNotes
                            ]
                        ]
                    ]
                ],
                "Action Plan": [
                    "rich_text": [
                        [
                            "type": "text",
                            "text": [
                                "content": actionPlan,
                                "link": nil
                            ],
                            "annotations": [
                                "bold": false,
                                "italic": false,
                                "strikethrough": false,
                                "underline": false,
                                "code": false,
                                "color": "default"
                            ],
                            "plain_text": actionPlan,
                            "href": nil
                        ]
                    ]
                ],
                "Category": [
                    "multi_select":[
                        [
                            "id": category.id,
                            "name": category.name,
                            "color": category.color
                        ]
                    ]
                ],
                "Challenge": [
                    "select": [
                        "id": challenge.id,
                        "name": challenge.name,
                        "color": challenge.color
                    ]
                ]
            ]
        ]
        
        let response = await callApi(url: "pages/", method: "POST", body: body)
        
        if (response["hasResponse"] != nil) {
            let isDone = createReflectionInCoreData(context: context, url: response["url"] as! String)
            if isDone {
                presentation.wrappedValue.dismiss()
            }
        } else {
            
        }
    }
    
    
    func createReflectionInCoreData(context: NSManagedObjectContext, url: String) -> Bool {
        print("Helper \(#function) url: \(url)")
        print("Helper \(#function) LN: \(learningNotes)")
        print("Helper \(#function) AP: \(actionPlan)")
        print("Helper \(#function) CA: \(category.name)")
        print("Helper \(#function) CH: \(challenge.name)")
        
        var item: Reflection!
        
        if let editItem = editItem {
            item = editItem
        } else {
            item = Reflection(context: context)
        }
        
        item.learningNotes = learningNotes
        item.actionPlan = actionPlan
        item.category = category.name
        item.challenge = challenge.name
        item.url = url
        item.createdAt = Date.now
        
        try? context.save()
        
        return true
    }
    
    func reset(){
        isSendingReflection = false
        learningNotes = ""
        actionPlan = ""
        category = Category(name: "Tech", id: "233466d5-2b42-43d6-b5c3-0b3b79a00be1", color: "blue")
        challenge = Challenge(name: "🏁 First Week", id: "3d783b44-9799-450a-87a8-9243339b810e", color: "purple")
    }
}
