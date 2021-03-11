//
//  TitleQuizForTestWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct TitleQuizForTestWriting: View {
    @ObservedObject var quizForTest: QuizForTest
    var kanaType: String
    var heightDevice: CGFloat
    
    var body: some View {
        Text("Draw \(kanaType.capitalized) for \(quizForTest.currentRomaji.capitalized)")
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleQuizForTestWriting_Previews: PreviewProvider {
    static var previews: some View {
        TitleQuizForTestWriting(
            quizForTest: QuizForTest(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                draw: true),
            kanaType: "Hiragana",
            heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
