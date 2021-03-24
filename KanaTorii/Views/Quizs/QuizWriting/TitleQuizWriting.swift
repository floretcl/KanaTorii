//
//  TitleQuizWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct TitleQuizWriting: View {
    @StateObject var quiz: Quiz
    var kanaType: String
    
    var heightDevice: CGFloat
    
    var body: some View {
        Text("Draw \(kanaType.capitalized) for \(quiz.currentName.capitalized)")
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleQuizWriting_Previews: PreviewProvider {
    static var previews: some View {
        TitleQuizWriting(
            quiz: Quiz(
                quickQuiz: true,
                difficulty: .hard,
                direction: .toKana,
                hiragana: false,
                katakana: true,
                kanaSection: .all,
                nbQuestions: 5.0),
            kanaType: "hiragana",
            heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
