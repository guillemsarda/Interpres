//
//  HomeView.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 17/8/25.
//

import SwiftUI

private let availableLanguages = [
    "es": "Español",
    "it": "Italiano"
]

struct HomeView: View {
    @State private var word: String = ""
    @State private var language: String = "es"
    @State private var isLoading: Bool = false
    @State private var translationResult: String?
    private var translationsRepository: TranslationsRepository
    
    init(translationsRepository: TranslationsRepository) {
        self.translationsRepository = translationsRepository
    }
    
    private func onPressSearch() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                let result = try await translationsRepository.translate(
                    word: word, source: "en", target: language
                )
                translationResult = result
            } catch {
                print("Error: \(error)")
            }
        }
    }
    @State private var isShowingDetailView = false
    
    var body: some View {
        VStack {
            Text("INTERPRES")
                .font(.custom("EBGaramond-Medium", size: 50))
                .padding(.top)
            TextField("Type a word", text: $word, prompt: Text("Type a word"))
                .autocapitalization(.none)
                .padding(15)
                .frame(width: 250, height: 50)
                .background(.white)
                .foregroundColor(Color("Green"))
                .cornerRadius(8)
                .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            Menu {
                Button("Español", action: { language = "es"})
                Button("Italiano", action: { language = "it"})
            } label: {
                Label(availableLanguages[language] ?? "", systemImage: "chevron.down")
                    .padding()
                    .frame(width: 250, height: 50, alignment: .leading)
                    .background(.white)
                    .foregroundColor(Color("Green"))
                    .cornerRadius(8)
            }
            Spacer()
            Button(action:{
                onPressSearch()
            }) {
                HStack {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(0.8)
                    }
                    Text(isLoading ? "" : "Search")
                }
            }
            .padding()
            .frame(width: 250, height: 50)
            .background(Color("Green"))
            .foregroundColor(.white)
            .cornerRadius(8)
            .opacity(word.isEmpty ? 0.7 : 1)
            .disabled(word.isEmpty || isLoading)
            .navigationDestination(item: $translationResult) { result in
                TranslationView(translation: result)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.accent)
    }
}

#Preview {
    HomeView(translationsRepository: TranslationsRepository())
}
