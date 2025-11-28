//
//  SnippetDetailView.swift
//  CodePocket
//
//  Created by Gökalp Gürocak on 27.11.2025.
//

import SwiftUI
import CodeEditor

struct SnippetDetailView: View {
    let snippet: Snippet
    @State var isCopied: Bool = false
    @State var isEditing: Bool = false
    @State var code: String = ""
    
    private var editorLanguage: CodeEditor.Language {
            switch snippet.language.lowercased() {
            case "swift": return .swift
            case "python": return .python
            case "javascript": return .javascript
            case "css": return .css
            case "html/css": return .css
            case "c": return .c
            default: return .markdown
            }
        }
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(snippet.title).font(.largeTitle.bold())
                    Button(action: {}) {
                        Label(snippet.language, systemImage: "tag.fill")
                    }.buttonStyle(.glass).disabled(true)
                    
                }
                Spacer()
                HStack {
                    Button(action: {
                        withAnimation(.snappy) {
                            isCopied = true
                        }
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(code, forType: .string)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    isCopied = false
                                }
                            }
                        
                            }) {
                    Label(isCopied ? "Kopyalandı" : "Kopyala",
                          systemImage: isCopied ? "checkmark.circle" : "doc.on.doc")
                    .contentTransition(.symbolEffect(.replace))
                            }
                            .buttonStyle(.glassProminent)
                            .disabled(isCopied)
                            .opacity(isEditing ? 0:1)
                    
                    Button(action: {
                        withAnimation(.snappy) {
                            isEditing.toggle()
                            if isEditing {
                                snippet.code = self.code
                            }
                        }
                        
                    }) {
                        Label(isEditing ? "Düzenlemeyi Bitir" : "Düzenle",
                              systemImage: isEditing ? "pencil.slash" : "pencil")
                        .contentTransition(.symbolEffect(.replace))
                    }.buttonStyle(.bordered)
                        .tint(isEditing ? .green : .primary)
                }
            }.padding()
            
            
            Divider()
            ZStack {
                CodeEditor(
                                source: $code,
                                language: editorLanguage,
                                theme: .default,
                                flags: isEditing ? .defaultEditorFlags : .selectable
                            )
                .cornerRadius(20)
            }.overlay(
                RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: isEditing ? 2 : 0)
                ).padding()
                .shadow(color: Color.blue.opacity(0.3), radius: isEditing ? 10 : 0)
                .animation(.easeInOut, value: isEditing)
            
        }.background(.ultraThinMaterial)
            .onAppear {
                        self.code = snippet.code
                    }
                    .onChange(of: snippet) { oldValue, newValue in
                        self.code = newValue.code
                        self.isEditing = false
                    }
    }
}

#Preview {
    //SnippetDetailView(snippet: sampleSnippets[0])
        //.frame(width: 400, height: 400)
}
