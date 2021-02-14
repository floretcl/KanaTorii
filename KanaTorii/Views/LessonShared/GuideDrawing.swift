//
//  GuideWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 08/02/2021.
//

import SwiftUI

struct GuideWriting: View {
    var romaji: String
    var kanaType: String
    var kana: Kana = Kana.default
    var imageFileName: String {
        return getLinesImageFilename(kana: kana, romaji: romaji, kanaType: kanaType)
    }
    
    var body: some View {
        Image(imageFileName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(0.25)
    }
}
func getLinesImageFilename(kana: Kana,romaji: String, kanaType: String) -> String {
    return kana.getLinesImageFilename(romaji: romaji, kanaType: kanaType == "hiragana" ? .hiragana : .katakana)
}

struct GuideWriting_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        Guide(kana: modelData.kanas[0], kanaType: "katakana")
            .previewLayout(.sizeThatFits)
    }
}
