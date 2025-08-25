//
//  HomeView.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 17/8/25.
//

import SwiftUI

struct TranslationView: View {
    @EnvironmentObject var translationStore: TranslationStore
    
    var body: some View {
        VStack {
            HStack {
                WordInput()
                SearchButton(isSmall: true)
            }
            .padding(.top)
            Text("Translation Result")
                .font(.title)
            Text(translationStore.translation ?? "")
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.accent)
    }
}

#Preview {
    let translationStore: TranslationStore = TranslationStore()
    translationStore.translation = "Traducción"
    return TranslationView().environmentObject(translationStore)
}
