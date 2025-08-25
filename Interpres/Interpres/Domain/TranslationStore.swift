//
//  TranslationEnvironment.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 25/8/25.
//

import Foundation

@MainActor
class TranslationStore: ObservableObject {
    @Published var word: String = ""
    @Published var language: String = "es"
    @Published var translation: String? = nil
    let translationsRepository: TranslationsRepository = TranslationsRepository()
    let availableLanguages = [
        "es": "Español",
        "it": "Italiano"
    ]
}
