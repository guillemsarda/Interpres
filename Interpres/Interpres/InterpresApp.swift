//
//  InterpresApp.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 15/8/25.
//

import SwiftUI

@main
struct InterpresApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(translationsRepository: TranslationsRepository())
            }
        }
    }
}
