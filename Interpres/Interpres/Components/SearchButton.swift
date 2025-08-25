//
//  SearchButton.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 25/8/25.
//

import SwiftUI

struct SearchButton: View {
    var isSmall: Bool
    @EnvironmentObject var translationStore: TranslationStore
    @State private var isLoading: Bool = false
    
    init(isSmall: Bool? = false) {
        self.isSmall = isSmall ?? false
    }
    private func onPressSearch() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                let result = try await translationStore.translationsRepository.translate(
                    word: translationStore.word, source: "en", target: translationStore.language
                )
                translationStore.translation = result
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    var body: some View {
        Button(action:{
            onPressSearch()
        }) {
            HStack {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                }
                if isSmall && !isLoading {
                    Image(systemName: "magnifyingglass")
                } else if !isSmall && !isLoading{
                    Text("Search")
                }
            }
            .frame(width: isSmall ? 50 : 250, height: 50, alignment: .center)
        }
        .background(Color("Green"))
        .foregroundColor(.white)
        .cornerRadius(8)
        .opacity(translationStore.word.isEmpty ? 0.7 : 1)
        .disabled(translationStore.word.isEmpty || isLoading)
    }
}

#Preview {
    let translationStore = TranslationStore()
    translationStore.word = "Hello"
    return SearchButton(isSmall: true).environmentObject(translationStore)
}
