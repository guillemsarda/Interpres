//
//  HomeView.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 17/8/25.
//

import SwiftUI

struct TranslationView: View {
    @EnvironmentObject var translationStore: TranslationStore
    @State private var cachedWord: String = ""
    
    private func onPressSearch() {
        Task {
            do {
                let result = try await translationStore.translationsRepository.translate(
                    word: translationStore.word, source: "en", target: translationStore.language
                )
                cachedWord = translationStore.word
                translationStore.translation = result
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                WordInput()
                SearchButton(isSmall: true, onPressSearch: onPressSearch)
            }
            .padding(.top)
            Text(cachedWord.prefix(1).capitalized + cachedWord.dropFirst())
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 20, leading: 50, bottom: 50, trailing: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(translationStore.translation ?? "")
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.accent)
        .onAppear {
            cachedWord = translationStore.word
        }
    }
}

#Preview {
    let translationStore: TranslationStore = TranslationStore()
    translationStore.word = "serendipity"
    translationStore.translation = "serendipia"
    return TranslationView().environmentObject(translationStore)
}
