//
//  KanaCell.swift
//  Kana Torii
//
//  Created by Clément FLORET on 01/01/2021.
//

import SwiftUI

struct KanaCell: View {
    @State var kana: Kana = Kana.default
    var kanaType: Kana.KanaType
    var kanaForList: KanaForList
    private var label: String {
        if kanaType == .hiragana {
            return self.kanaForList.hiragana
        } else {
            return self.kanaForList.katakana
        }
    }
    
    var body: some View {
        NavigationLink(
            destination: DetailsView(
                currentPage: getId(),
                pages: ModelData().kanas.map {
                    DetailPage(kana: $0, kanaType: kanaType)
                }
            ),
            label: {
                VStack {
                    Text(self.label)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text(self.kanaForList.romaji)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
        )
    }
    
    func getId() -> Int {
        if kanaForList.name != "" {
            return kana.getIdKana(name: kanaForList.name)
        }
        return 0
    }
}

struct KanaCell_Previews: PreviewProvider {
    static var kanasForList = ModelData().kanasForList
    static var previews: some View {
        Group {
            KanaCell(kanaType: .hiragana, kanaForList: kanasForList[10])
                .previewLayout(.sizeThatFits)
            KanaCell(kanaType: .katakana, kanaForList: kanasForList[13])
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
