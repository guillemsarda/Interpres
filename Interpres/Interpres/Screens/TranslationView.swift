//
//  HomeView.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 17/8/25.
//

import SwiftUI

struct TranslationView: View {
    let translation: String
    
    var body: some View {
        VStack {
            Text("Translation Result")
                .font(.title)
            Text(translation)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.accent)
    }
}

#Preview {
    TranslationView(translation: "Gato")
}
