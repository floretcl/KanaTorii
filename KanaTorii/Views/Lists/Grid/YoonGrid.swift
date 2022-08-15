//
//  YoonGrid.swift
//  Kana Torii
//
//  Created by Clément FLORET on 16/01/2021.
//

import SwiftUI

struct YoonGrid: View {
    @EnvironmentObject var modelData: ModelData
    var kanasForList: [KanaForList] {
        return modelData.kanasForList
    }
    // User Defaults
    @AppStorage var colorsInTables: Bool

    let limitDakuonHandakuon: Int = 80
    let limitYoon: Int = 113
    let itemsCell = GridItem(.flexible(minimum: 30, maximum: 190))
    var kanaType: Kana.KanaType
    var widthDevice: CGFloat

    var body: some View {
        LazyVGrid(
            columns: [itemsCell, itemsCell, itemsCell],
            alignment: .center,
            spacing: widthDevice/20,
            content: {
                ForEach(limitDakuonHandakuon..<limitYoon, id: \.self) { index in
                    KanaCell(colorsInTables: _colorsInTables, kanaForList: kanasForList[index], kanaType: self.kanaType, widthDevice: widthDevice)
            }
        })
        .padding(.top, 20)
        .padding(.bottom, 60)
    }
}

struct YoonGrid_Previews: PreviewProvider {
    static var previews: some View {
        YoonGrid(colorsInTables: .init(wrappedValue: true, "colors-in-tables"), kanaType: .hiragana, widthDevice: 400)
            .environmentObject(ModelData())
    }
}
