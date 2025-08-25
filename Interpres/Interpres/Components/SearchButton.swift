//
//  SearchButton.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 25/8/25.
//

import SwiftUI

struct SearchButton: View {
    @EnvironmentObject var translationStore: TranslationStore
    @State private var isLoading: Bool = false
    private var isSmall: Bool
    private var onPressSearch: () async -> Void = { }
    
    init(isSmall: Bool? = false, onPressSearch: @escaping () -> Void) {
        self.isSmall = isSmall ?? false
        self.onPressSearch = onPressSearch
    }
    
    var body: some View {
        Button(action: {
            Task {
                isLoading = true
                defer {
                    isLoading = false
                }
                await onPressSearch()
                isLoading = false
            }
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
    
    return SearchButton(isSmall: true, onPressSearch: {
        print("Clicked")
    }).environmentObject(translationStore)
}
