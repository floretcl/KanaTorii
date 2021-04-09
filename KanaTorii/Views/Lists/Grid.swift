//
//  Grid.swift
//  Kana Torii
//
//  Created by Clément FLORET on 04/01/2021.
//

import SwiftUI

struct Grid: View {
    // User Defaults
    @AppStorage var colorsInTables: Bool
    
    var kanaType: Kana.KanaType
    var heightDevice: CGFloat
    var widthDevice: CGFloat
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            VStack {
                Section(header: CustomSection(label: "Gojuon").padding(.bottom, heightDevice/40)) {
                    GojuonGrid(colorsInTables: _colorsInTables, kanaType: kanaType, widthDevice: widthDevice)
                }
                Section(header: CustomSection(label: "Dakuon & Handakuon").padding(.bottom, heightDevice/40)) {
                    DakuonHandakuonGrid(colorsInTables: _colorsInTables, kanaType: kanaType, widthDevice: widthDevice)
                }
                Section(header: CustomSection(label: "Yoon").padding(.bottom, heightDevice/40)) {
                    YoonGrid(colorsInTables: _colorsInTables, kanaType: kanaType, widthDevice: widthDevice)
                }
            }
        })
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(colorsInTables: .init(wrappedValue: true, "colors-in-tables"), kanaType: .hiragana, heightDevice: 800, widthDevice: 350)
            .environmentObject(ModelData())
    }
}
