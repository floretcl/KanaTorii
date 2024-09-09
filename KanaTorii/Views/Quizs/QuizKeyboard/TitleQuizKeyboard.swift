//
//  TitleQuizKeyboard.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct TitleQuizKeyboard: View {
    @StateObject var quiz: Quiz

    var heightDevice: CGFloat

    var body: some View {
        Text("Write the Romaji for \(quiz.currentKana.capitalized)")
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleQuizKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        TitleQuizKeyboard(
            quiz: Quiz(
                quickQuiz: true,
                difficulty: .hard,
                direction: .toRomaji,
                hiragana: true,
                katakana: false,
                kanaSection: .all,
                nbQuestions: 10.0),
            heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
