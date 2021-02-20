//
//  GuideTest.swift
//  KanaTorii
//
//  Created by Clément FLORET on 08/02/2021.
//

import SwiftUI

struct GuideTest: View {
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
            .opacity(0.5)
    }
}
func getLinesImageFilename(kana: Kana,romaji: String, kanaType: String) -> String {
    return kana.getLinesImageFilename(romaji: romaji, kanaType: kanaType == "hiragana" ? .hiragana : .katakana)
}

struct GuideTest_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        GuideTest(romaji: "a", kanaType: "katakana")
            .previewLayout(.sizeThatFits)
    }
}
