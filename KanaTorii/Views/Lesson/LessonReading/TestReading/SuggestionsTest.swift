//
//  SuggestionsTest.swift
//  KanaTorii
//
//  Created by Clément FLORET on 19/02/2021.
//

import SwiftUI

struct SuggestionsTest: View {
    @StateObject var test: Test
    var items: GridItem
    var spacing: CGFloat
    var textSize: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    @Binding var showActionSheet: Bool
    
    var body: some View {
        LazyVGrid(
            columns: [items,items],
            alignment: .center,
            spacing: spacing,
            content: {
                ForEach(0..<test.suggestions.count) { index in
                    SuggestionCellTest(
                        test: test,
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

struct SuggestionsTest_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsTest(
            test: Test(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                currentIndex: 0),
            items: GridItem(.fixed(120)),
            spacing: 30,
            textSize: 30,
            width: 100,
            height: 100,
            showActionSheet: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
