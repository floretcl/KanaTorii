//
//  GreenSegmentedControl.swift
//  Kana Torii
//
//  Created by Clément FLORET on 02/01/2021.
//

import SwiftUI

struct GreenSegmentedControl: View {
    @State var pickerSelection = "hiragana"
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("Green"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("Green"))], for: .normal)
    }
    
    var body: some View {
        Picker("Kana Type", selection: $pickerSelection, content: {
            Text("Hiragana").tag("hiragana")
            Text("Katakana")
                .tag("katakana")
        })
        .pickerStyle((SegmentedPickerStyle()))
        .padding(10.0)
    }
}

struct GreenSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        GreenSegmentedControl()
            .previewLayout(.sizeThatFits)
    }
}
