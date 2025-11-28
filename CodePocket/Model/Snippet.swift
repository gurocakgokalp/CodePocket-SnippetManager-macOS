//
//  Snippet.swift
//  CodePocket
//
//  Created by Gökalp Gürocak on 27.11.2025.
//
import Foundation
import SwiftData

/*
let sampleSnippets = [
    Snippet(title: "URLSession Request", language: "Swift", code: """
    let url = URL(string: "https://api.example.com")!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            print(String(data: data, encoding: .utf8)!)
        }
    }
    task.resume()
    """, date: Date()),
    
    Snippet(title: "List Boşluklarını Silme", language: "C", code: """
    .listStyle(.plain)
    .listRowInsets(EdgeInsets())
    """, date: Date().addingTimeInterval(-86400)),
    
    Snippet(title: "Python API Call", language: "Python", code: """
    import requests
    response = requests.get('https://api.github.com')
    print(response.status_code)
    """, date: Date().addingTimeInterval(-172800))
]
 */

@Model
class Snippet: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var language: String
    var code: String
    var date: Date
    
    init(id: UUID = UUID(), title: String, language: String, code: String, date: Date) {
        self.id = id
        self.title = title
        self.language = language
        self.code = code
        self.date = date
    }
}
