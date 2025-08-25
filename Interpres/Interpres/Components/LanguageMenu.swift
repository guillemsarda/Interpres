//
//  LanguageMenu.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 25/8/25.
//
import SwiftUI

struct LanguageMenu: View {
    @EnvironmentObject var translationStore: TranslationStore

    var body: some View {
        Menu {
            Button("Español", action: { translationStore.language = "es"})
            Button("Italiano", action: { translationStore.language = "it"})
        } label: {
            Label(translationStore.availableLanguages[translationStore.language] ?? "", systemImage: "chevron.down")
                .padding()
                .frame(width: 250, height: 50, alignment: .leading)
                .background(.white)
                .foregroundColor(Color("Green"))
                .cornerRadius(8)
        }
    }
}
