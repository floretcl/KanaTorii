//
//  SuggestionsQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 24/02/2021.
//

import SwiftUI

struct SuggestionsQuiz: View {
    @ObservedObject var quiz: Quiz
    
    var items: GridItem
    var spacing: CGFloat
    var width: CGFloat
    var height: CGFloat
    var textSize: CGFloat
    
    @Binding var showActionSheet: Bool
    
    var body: some View {
        LazyVGrid(
            columns: [items,items,items],
            alignment: .center,
            spacing: spacing,
            content: {
                ForEach(0..<quiz.suggestions!.count) { index in
                    SuggestionCellQuiz(
                        quiz: quiz,
                        index: index,
                        width: width,
                        height: height,
                        textSize: textSize,
                        showActionSheet: $showActionSheet)
                }
            }
        )
    }
}

struct SuggestionsQuiz_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsQuiz(
            quiz: Quiz(
                quickQuiz: false,
                difficulty: .easy,
                direction: .toRomaji,
                hiragana: true,
                katakana: false,
                kanaSection: .all,
                nbQuestions: 10.0),
            items: GridItem(.fixed(110)),
            spacing: 30,
            width: 90,
            height: 90,
            textSize: 30,
            showActionSheet: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
