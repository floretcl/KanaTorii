//
//  Grid.swift
//  Kana Torii
//
//  Created by Clément FLORET on 04/01/2021.
//

import SwiftUI

struct Grid: View {
    var kanaType: Kana.KanaType
    var heightDevice: CGFloat
    var widthDevice: CGFloat
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            VStack {
                Section(header: CustomSection(label: "Gojuon").padding(.bottom, heightDevice/40)) {
                    GojuonGrid(kanaType: kanaType, widthDevice: widthDevice)
                }
                Section(header: CustomSection(label: "Dakuon & Handakuon").padding(.bottom, heightDevice/40)) {
                    DakuonHandakuonGrid(kanaType: kanaType, widthDevice: widthDevice)
                }
                Section(header: CustomSection(label: "Yoon").padding(.bottom, heightDevice/40)) {
                    YoonGrid(kanaType: kanaType, widthDevice: widthDevice)
                }
            }
        })
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(kanaType: .hiragana, heightDevice: 800, widthDevice: 350)
            .environmentObject(ModelData())
    }
}
