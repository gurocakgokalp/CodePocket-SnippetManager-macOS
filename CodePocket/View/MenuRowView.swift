//
//  MenuRowView.swift
//  CodePocket
//
//  Created by Gökalp Gürocak on 28.11.2025.
//
import SwiftUI


struct MenuRowView: View {
    let snippet: Snippet
    @State private var isCopied = false
    
    var body: some View {
        Button(action: {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(snippet.code, forType: .string)
            
            withAnimation(.snappy) {
                isCopied = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    isCopied = false
                }
            }
        }) {
            HStack {
                Image(systemName: isCopied ? "checkmark.circle.fill" : "doc.on.doc")
                    .foregroundStyle(isCopied ? .green : .primary)
                    .contentTransition(.symbolEffect(.replace))
                
                VStack(alignment: .leading) {
                    Text(isCopied ? "Kopyalandı!" : snippet.title)
                        .foregroundStyle(isCopied ? .green : .primary)
                        .fontWeight(isCopied ? .bold : .regular)
                    
                    if !isCopied {
                        Text(snippet.language)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(isCopied ? Color.green.opacity(0.1) : Color.clear)
            .cornerRadius(6)
        }
        .buttonStyle(.plain)
    }
}
