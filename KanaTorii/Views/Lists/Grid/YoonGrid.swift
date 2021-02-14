//
//  YoonGrid.swift
//  Kana Torii
//
//  Created by Clément FLORET on 16/01/2021.
//

import SwiftUI

struct YoonGrid: View {
    @EnvironmentObject var modelData: ModelData
    var widthDevice: CGFloat
    let itemsYoonCell = GridItem(.flexible(minimum: 30, maximum: 210))
    let limitYoon: Int = 113
    let limitDakuonHandakuon: Int = 80
    var type: Kana.KanaType
    var kanasForList: [KanaForList] {
        return modelData.kanasForList
    }
    
    var body: some View {
        HStack {
            Spacer()
            LazyVGrid(
                columns: [itemsYoonCell, itemsYoonCell, itemsYoonCell],
                alignment: .center,
                spacing: widthDevice/20,
                content: {
                    ForEach(limitDakuonHandakuon..<limitYoon) { index in
                        KanaCell(kanaType: self.type, kanaForList: kanasForList[index])
                            .padding(.vertical, widthDevice/60)
                            .padding(.horizontal, widthDevice/35)
                            .overlay(RoundedRectangle(cornerRadius: widthDevice/50)
                                        .stroke(Color.primary, lineWidth: 0.5))
                    }
            })
            .padding(.top, 20)
            .padding(.bottom, 60)
            Spacer()
        }
    }
}

struct YoonGrid_Previews: PreviewProvider {
    static var previews: some View {
        YoonGrid(widthDevice: 400, type: .hiragana)
            .environmentObject(ModelData())
    }
}
