//
//  GreenSegmentedControl.swift
//  Kana Torii
//
//  Created by Clément FLORET on 02/01/2021.
//

import SwiftUI

struct GreenSegmentedControl: View {
    @Binding var pickerSelection: String
    
    
    
    var body: some View {
        Picker("Kana Type", selection: $pickerSelection, content: {
            Text("Hiragana").tag("hiragana")
            Text("Katakana")
                .tag("katakana")
        })
        .pickerStyle((SegmentedPickerStyle()))
    }
}

struct GreenSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        GreenSegmentedControl(pickerSelection: .constant("hiragana"))
            .previewLayout(.sizeThatFits)
    }
}
