//
//  Grid.swift
//  Kana Torii
//
//  Created by Clément FLORET on 04/01/2021.
//

import SwiftUI

struct Grid: View {
    var type: Kana.KanaType
    var heightDevice: CGFloat
    var widthDevice: CGFloat
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            VStack {
                Section(header: CustomSection(label: "Gojuon").padding(.bottom, heightDevice/40)) {
                    GojuonGrid(widthDevice: widthDevice, type: type)
                }
                Section(header: CustomSection(label: "Dakuon & Handakuon").padding(.bottom, heightDevice/40)) {
                    DakuonHandakuonGrid(widthDevice: widthDevice, type: type)
                }
                Section(header: CustomSection(label: "Yoon").padding(.bottom, heightDevice/40)) {
                    YoonGrid(widthDevice: widthDevice, type: type)
                }
            }
        })
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(type: .hiragana, heightDevice: 800, widthDevice: 350)
            .environmentObject(ModelData())
    }
}
