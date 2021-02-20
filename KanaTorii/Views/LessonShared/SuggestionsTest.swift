//
//  SuggestionsTest.swift
//  KanaTorii
//
//  Created by Clément FLORET on 19/02/2021.
//

import SwiftUI

struct SuggestionsTest: View {
    @ObservedObject var test: Test
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
                ForEach(0..<test.suggestions.count) { index in
                    SuggestionCell(
                        test: test,
                        showActionSheet: $showActionSheet,
                        index: index,
                        width: width,
                        height: height, textSize: textSize)
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
                currentIndex: 0), showActionSheet: .constant(false),
            items: GridItem(.fixed(120)),
            spacing: 30,
            width: 100,
            height: 100,
            textSize: 30)
    }
}
