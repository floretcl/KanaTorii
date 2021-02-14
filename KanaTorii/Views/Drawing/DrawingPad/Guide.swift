//
//  Guide.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct Guide: View {
    var kana: Kana
    var kanaType: String
    var imageFileName: String {
        if kanaType == "hiragana" {
            return kana.fileNameHiraganaWithLineOrder
        } else {
            return kana.fileNameKatakanaWithLineOrder
        }
    }
    var body: some View {
        Image(imageFileName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(0.5)
    }
}

struct Guide_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        Guide(kana: modelData.kanas[0], kanaType: "katakana")
    }
}
