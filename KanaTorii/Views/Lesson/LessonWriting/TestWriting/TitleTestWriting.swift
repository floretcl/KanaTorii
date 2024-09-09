//
//  TitleTestWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct TitleTestWriting: View {
    @StateObject var test: TestDrawing
    var kanaType: String

    var heightDevice: CGFloat

    var body: some View {
        Text("Practice drawing \(kanaType.capitalized): \(test.romaji.capitalized)")
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleTestWriting_Previews: PreviewProvider {
    static var previews: some View {
        TitleTestWriting(
            test: TestDrawing(type: .hiragana, kana: "あ", romaji: "a"),
            kanaType: "Hiragana",
            heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
