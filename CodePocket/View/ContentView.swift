//
//  ContentView.swift
//  CodePocket
//
//  Created by Gökalp Gürocak on 27.11.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Snippet.date, order: .reverse) private var snippets: [Snippet]
    
    @State var selectedSnippet: Snippet?
    @State private var isShowingAddSheet = false
    @State var searchText: String = ""
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedSnippet) {
                ForEach(snippets) { snippet in
                    if searchText.isEmpty || snippet.title.localizedCaseInsensitiveContains(searchText) {
                        NavigationLink(value: snippet) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(snippet.title).font(.headline).lineLimit(1)
                                HStack {
                                    Button(action: {}) {
                                        Label(snippet.language, systemImage: "tag.fill")
                                    }.disabled(true)
                                    Spacer()
                                    Text(snippet.date.formatted(date: .numeric, time: .shortened)).lineLimit(1).font(.caption).foregroundStyle(.secondary)
                                }
                                
                            }.padding()
                        }.contextMenu {
                            Button(role: .destructive) {
                                context.delete(snippet)
                                if selectedSnippet == snippet {
                                    selectedSnippet = nil
                                }
                            } label: {
                                Label("Sil", systemImage: "trash")
                            }
                        }
                    }
                }
            }.navigationTitle("Code Pocket")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            isShowingAddSheet = true
                        }) {
                            Label("Ekle", systemImage: "plus")
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Kod Ara")
                .onDeleteCommand {
                    if let selected = selectedSnippet {
                        context.delete(selected)
                        selectedSnippet = nil
                    }
                }
                
        } detail: {
            if selectedSnippet != nil {
                SnippetDetailView(snippet: selectedSnippet!, code: selectedSnippet!.code)
                    .transition(.slide).animation(.snappy, value: selectedSnippet)
            } else {
                ContentUnavailableView("Snippet Seçilmedi", systemImage: "chevron.left.slash.chevron.right", description: Text("Sol Taraftan Bir Snippet Seç"))
            }
        }.navigationSplitViewStyle(.balanced)
            .sheet(isPresented: $isShowingAddSheet) {
                AddSnippetView()
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("OpenAddSnippet"))) { _ in
                        isShowingAddSheet = true
                    }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("add"))) { _ in
                        selectedSnippet = nil
                    }

    }
}

#Preview {
    ContentView().frame(width: 800, height: 500)
}
