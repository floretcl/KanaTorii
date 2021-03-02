//
//  SuggestionsTestQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct SuggestionsTestQuiz: View {
    @ObservedObject var quizForTest: QuizForTest
    @Binding var showActionSheet: Bool
    var items: GridItem
    var spacing: CGFloat
    var width: CGFloat
    var height: CGFloat
    var textSize: CGFloat
    
    var body: some View {
        LazyVGrid(
            columns: [items,items],
            alignment: .center,
            spacing: spacing,
            content: {
                ForEach(0..<quizForTest.suggestions!.count) { index in
                    SuggestionCellTestQuiz(
                        quizForTest: quizForTest,
                        showActionSheet: $showActionSheet,
                        index: index,
                        width: width,
                        height: height, textSize: textSize)
                }
            }
        )
    }
}

struct SuggestionsTestQuiz_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsTestQuiz(
            quizForTest: QuizForTest(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                draw: false),
            showActionSheet: .constant(false),
            items: GridItem(.fixed(120)),
            spacing: 30,
            width: 100,
            height: 100,
            textSize: 30)
            .previewLayout(.sizeThatFits)
    }
}
