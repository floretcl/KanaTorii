//
//  TitleDraw.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct TitleDraw: View {
    var kanaType: String
    var kana: Kana
    var sizeText: CGFloat
    private var kanaLabel: String {
        if kanaType == "hiragana" {
            return kana.hiragana
        } else {
            return kana.katakana
        }
    }
    var body: some View {
        Text("\(kanaType.capitalized):   \(kana.romaji.capitalized) ->  \(kanaLabel)")
            .font(.system(size: sizeText))
            .fontWeight(.medium)
    }
}

struct TitleDraw_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        TitleDraw(kanaType: "hiragana", kana: modelData.kanas[20], sizeText: 20)
            .previewLayout(.sizeThatFits)
    }
}