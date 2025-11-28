//
//  CodePocketApp.swift
//  CodePocket
//
//  Created by Gökalp Gürocak on 27.11.2025.
//

import SwiftUI
import SwiftData

@main
struct CodePocketApp: App {
    //let snippets = sampleSnippets
    @Environment(\.modelContext) private var context
    
    var sharedModelContainer: ModelContainer = {
            let schema = Schema([
                Snippet.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("ModelContainer oluşturulamadı: \(error)")
            }
        }()
    
    var body: some Scene {
        Window("CodePocket", id: "main"){
            ContentView().frame(width: 1000, height: 700)
            //baska contentView açma
                .handlesExternalEvents(preferring: Set(arrayLiteral: "main"), allowing: Set(arrayLiteral: "*"))
        }.windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        .commands {
            SidebarCommands()
            CommandGroup(replacing: .newItem) { } //cmd n kalktı
        }
        
        MenuBarExtra("CodePocket", systemImage: "curlybraces") {
                    MenuBarContentView()
                .modelContainer(sharedModelContainer)
                }
                .menuBarExtraStyle(.window)
        
    }
}
