//
//  InterpresApp.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 15/8/25.
//

import SwiftUI

@main
struct InterpresApp: App {
    @StateObject private var translationStore = TranslationStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }.environmentObject(translationStore)
        }
    }
}
