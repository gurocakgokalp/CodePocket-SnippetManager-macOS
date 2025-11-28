//
//  AddSnippetView.swift
//  CodePocket
//
//  Created by Gökalp Gürocak on 27.11.2025.
//

import SwiftUI
import CodeEditor
import SwiftData

struct AddSnippetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    let languages = ["Swift", "Python", "JavaScript", "C++", "HTML/CSS", "C"]
    
    @State private var title: String = ""
    @State private var language: String = "C"
    @State private var code: String = ""
    
    private var editorLanguage: CodeEditor.Language {
        switch language.lowercased() {
        case "swift": return .swift
        case "python": return .python
        case "javascript": return .javascript
        case "c++": return .cpp
        case "html/css": return .basic
        case "c": return .c
        default: return .markdown
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Snippet Bilgileri") {
                    TextField("Başlık (Örn: URL Request)", text: $title)
                    
                    Picker("Dil", selection: $language) {
                        ForEach(languages, id: \.self) { lang in
                            Text(lang).tag(lang)
                        }
                    }
                }
                
                Section("Kod Parçası") {
                    CodeEditor(
                        source: $code,
                        language: editorLanguage,
                        theme: .default,
                        flags: .defaultEditorFlags
                    )
                    .frame(minHeight: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Yeni Snippet Ekle")
            .toolbar {
                // İPTAL BUTONU (Sol)
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") {
                        dismiss()
                    }
                    .keyboardShortcut(.escape)
                }
            
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        print("Kaydediliyor: \(title)")
                        let snippet = Snippet(title: title, language: language, code: code, date: Date())
                        context.insert(snippet)
                        //burada selectedSnippet tetikle.
                        NotificationCenter.default.post(name: NSNotification.Name("add"), object: nil)
                        dismiss()
                    }
                    .disabled(title.isEmpty || code.isEmpty)
                }
            }
        }
        .frame(width: 500, height: 500)
    }
}

#Preview {
    AddSnippetView()
}
