//
//  ListsView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/12/2020.
//

import SwiftUI

struct ListsView: View {
    // User Defaults
    @AppStorage var colorsInTables: Bool

    @State var pickerSelection: String = "hiragana"
    private var kanaType: Kana.KanaType {
        if pickerSelection == "hiragana" {
            return .hiragana
        } else {
            return .katakana
        }
    }

    var body: some View {
        NavigationView(content: {
            VStack {
                Grid(colorsInTables: _colorsInTables, kanaType: kanaType)
                HStack {
                    Spacer()
                    GreenSegmentedControl(pickerSelection: $pickerSelection)
                    .frame(maxWidth: 600, alignment: .center)
                    .padding(.top, 5.0)
                    .padding(.bottom, 10.0)
                    Spacer()
                }
            }
            .navigationBarTitle("\(pickerSelection.capitalized) charts", displayMode: .inline)
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListsView(colorsInTables: .init(wrappedValue: true, "colors-in-tables"))
                .environmentObject(ModelData())
        }
    }
}
