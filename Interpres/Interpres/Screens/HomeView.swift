//
//  HomeView.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 17/8/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var translationStore: TranslationStore
    
    var body: some View {
        VStack {
            Text("INTERPRES")
                .font(.custom("EBGaramond-Medium", size: 50))
                .padding(.top)
            WordInput()
                .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            LanguageMenu()
            Spacer()
            SearchButton()
            .navigationDestination(item: $translationStore.translation) {_ in
                TranslationView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.accent)
    }
}

#Preview {
    HomeView().environmentObject(TranslationStore())
}
