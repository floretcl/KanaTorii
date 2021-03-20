//
//  GojuonGrid.swift
//  Kana Torii
//
//  Created by Clément FLORET on 16/01/2021.
//

import SwiftUI

struct GojuonGrid: View {
    @EnvironmentObject var modelData: ModelData
    var kanasForList: [KanaForList] {
        return modelData.kanasForList
    }
    
    let limitGojuon: Int = 51
    let itemsCell = GridItem(.flexible(minimum: 30, maximum: 130))
    var kanaType: Kana.KanaType
    var widthDevice: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
            LazyVGrid(
                columns: [itemsCell, itemsCell, itemsCell, itemsCell, itemsCell],
                alignment: .center,
                spacing: widthDevice/20,
                content: {
                    ForEach(0..<limitGojuon) { index in
                        KanaCell(kanaForList: kanasForList[index], kanaType: self.kanaType, widthDevice: widthDevice)
                    }
            })
            .padding(.top, 20)
            .padding(.bottom, 60)
            Spacer()
        }
    }
}

struct GojuonGrid_Previews: PreviewProvider {
    static var previews: some View {
        GojuonGrid(kanaType: .hiragana, widthDevice: 400)
            .environmentObject(ModelData())
    }
}
