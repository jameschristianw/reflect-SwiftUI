//
//  APIService.swift
//  Reflect (iOS)
//
//  Created by James Christian Wira on 27/07/22.
//

import Foundation
import SwiftUI
import CoreData

func callApi(url: String, method: String, body: [String: Any] = [:]) async -> [String: Any] {
    
    guard let url = URL(string: "https://api.notion.com/v1/\(url)") else {
        return ["hasResponse": false]
    }
    
    var request = URLRequest(url: url)
    // method, body, headers
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer secret_81voZYy0y0riPDxxWKhokRvJmkCOk6ax1baZdVwbcXf", forHTTPHeaderField: "Authorization")
    request.setValue("2022-06-28", forHTTPHeaderField: "Notion-Version")
    
    if !body.isEmpty {
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
    }
    
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]

        print(response!["url"] ?? [:])
        
        return [
            "hasResponse": true,
            "url": response!["url"]!
        ]

    } catch {
        print(error)

        return [
            "hasResponse": false
        ]
    }
    
}
