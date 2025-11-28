//
//  MenuBarContentView.swift
//  CodePocket
//
//  Created by Gökalp Gürocak on 28.11.2025.
//
import SwiftUI
import SwiftData


struct MenuBarContentView: View {
    @Query(sort: \Snippet.date, order: .reverse) private var snippets: [Snippet]

    @Environment(\.openWindow) var openWindow
    
    let limit = 5
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Hızlı Erişim").bold().padding([.top, .bottom])
            Divider()
            if snippets.isEmpty {
                            Text("Henüz snippet yok")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(snippets.prefix(limit)) { snippet in
                            MenuRowView(snippet: snippet)
                        }
                    }
                    .padding(5)
                }
                .frame(maxHeight: 250)
            }
            
            if snippets.count > limit {
                                Divider()
                                Button("Tümünü Gör (\(snippets.count - limit) daha)") {
                                    openWindow(id: "main")
                                    NSApp.activate(ignoringOtherApps: true)
                                }
                                .buttonStyle(.plain)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                            }
            
            Divider()
            
            HStack {
                Button("Uygulamayı Aç") {
                    openWindow(id: "main")
                    NSApp.activate(ignoringOtherApps: true)
                }
                .keyboardShortcut("o")
                
                Button(action: {
                    openWindow(id: "main")
                    NSApp.activate(ignoringOtherApps: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        NotificationCenter.default.post(name: NSNotification.Name("OpenAddSnippet"), object: nil)
                    }
                    
                }) {
                    HStack {
                        Text("Yeni Snippet")
                    }
                }
                .onHover { isHovering in
                    if isHovering { NSCursor.pointingHand.push() } else { NSCursor.pop() }
                }
            }
            .padding(.bottom)
            .padding([.top, .bottom])
        }
        .frame(width: 280)
        .background(Material.regular)
    }
}
