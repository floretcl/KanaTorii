//
//  SuggestionsMiniQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct SuggestionsMiniQuiz: View {
    // Core data
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var miniQuiz: MiniQuiz

    var items: GridItem
    var spacing: CGFloat
    var width: CGFloat
    var height: CGFloat
    var textSize: CGFloat

    @Binding var showActionSheet: Bool

    var body: some View {
        LazyVGrid(
            columns: [items, items],
            alignment: .center,
            spacing: spacing,
            content: {
                ForEach(0..<miniQuiz.suggestions!.count, id: \.self) { index in
                    SuggestionCellMiniQuiz(
                        miniQuiz: miniQuiz,
                        index: index,
                        width: width,
                        height: height,
                        textSize: textSize,
                        showActionSheet: $showActionSheet)
                        .environment(\.managedObjectContext, self.viewContext)
                }
            }
        )
    }
}

struct SuggestionsMiniQuiz_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsMiniQuiz(
            miniQuiz: MiniQuiz(
                type: .hiragana,
                kanas: ["あ", "い", "う", "え", "お"],
                romajis: ["a", "i", "u", "e", "o"],
                draw: false),
            items: GridItem(.fixed(120)),
            spacing: 30,
            width: 100,
            height: 100,
            textSize: 30,
            showActionSheet: .constant(false))
            .previewLayout(.sizeThatFits)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
