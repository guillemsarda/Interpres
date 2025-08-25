//
//  WordInput.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 25/8/25.
//

import SwiftUI

struct WordInput: View {
    @EnvironmentObject var translationStore: TranslationStore
    
    var body: some View {
        TextField("Type a word", text: $translationStore.word, prompt: Text("Type a word"))
            .autocapitalization(.none)
            .padding(15)
            .frame(width: 250, height: 50)
            .background(.white)
            .foregroundColor(Color("Green"))
            .cornerRadius(8)
    }
}
