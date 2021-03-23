//
//  TitleDraw.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct TitleDraw: View {
    var kana: Kana
    var kanaType: String
    private var kanaLabel: String {
        if kanaType == "hiragana" {
            return kana.hiragana
        } else {
            return kana.katakana
        }
    }
    var sizeText: CGFloat
    
    var body: some View {
        Text("\(kanaType.capitalized):   \(kana.romaji.capitalized) \(kanaLabel)")
            .font(.system(size: sizeText))
            .fontWeight(.medium)
    }
}

struct TitleDraw_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        TitleDraw(kana: modelData.kanas[20], kanaType: "hiragana", sizeText: 20)
            .previewLayout(.sizeThatFits)
    }
}
