//
//  TitleMiniQuizWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct TitleMiniQuizWriting: View {
    @ObservedObject var miniQuiz: MiniQuiz
    var kanaType: String
    
    var heightDevice: CGFloat
    
    var body: some View {
        Text("Draw \(kanaType.capitalized) for \(miniQuiz.currentRomaji.capitalized)")
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleMiniQuizWriting_Previews: PreviewProvider {
    static var previews: some View {
        TitleMiniQuizWriting(
            miniQuiz: MiniQuiz(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                draw: true),
            kanaType: "Hiragana",
            heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
