//
//  GojuonGrid.swift
//  Kana Torii
//
//  Created by Clément FLORET on 16/01/2021.
//

import SwiftUI

struct GojuonGrid: View {
    @EnvironmentObject var modelData: ModelData
    var widthDevice: CGFloat
    let itemsCell = GridItem(.flexible(minimum: 30, maximum: 130))
    let limitGojuon: Int = 51
    var type: Kana.KanaType
    var kanasForList: [KanaForList] {
        return modelData.kanasForList
    }
    
    var body: some View {
        HStack {
            Spacer()
            LazyVGrid(
                columns: [itemsCell, itemsCell, itemsCell, itemsCell, itemsCell],
                alignment: .center,
                spacing: widthDevice/20,
                content: {
                    ForEach(0..<limitGojuon) { index in
                        if kanasForList[index].isKana {
                            KanaCell(kanaType: self.type, kanaForList: kanasForList[index])
                                .padding(.vertical, widthDevice/60)
                                .padding(.horizontal, widthDevice/40)
                                .overlay(RoundedRectangle(cornerRadius: widthDevice/50)
                                        .stroke(Color.primary, lineWidth: 0.5))
                        } else {
                            KanaCell(kanaType: self.type, kanaForList: kanasForList[index])
                                .padding(.vertical, widthDevice/60)
                                .padding(.horizontal, widthDevice/40)
                        }
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
        GojuonGrid(widthDevice: 400, type: .hiragana)
            .environmentObject(ModelData())
    }
}
