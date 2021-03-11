//
//  ListsView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/12/2020.
//

import SwiftUI

struct ListsView: View {
    @State var pickerSelection: String = "hiragana"
    @State var showSettings = false
    private var kanaType: Kana.KanaType {
        if pickerSelection == "hiragana" {
            return .hiragana
        } else {
            return .katakana
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            NavigationView(content: {
                VStack {
                    Grid(type: kanaType, heightDevice: heightDevice, widthDevice: widthDevice)
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
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListsView()
                .environmentObject(ModelData())
        }
    }
}
