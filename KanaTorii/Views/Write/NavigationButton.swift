//
//  NavigationButton.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct NavigationButton: View {
    var text: String
    var systemImage: String
    var sizeText: CGFloat
    var inversed: Bool
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        if inversed != true {
            NavigationButtonLabel(text: text, systemImage: systemImage, sizeText: sizeText, inversed: inversed, width: width, height: height)
        } else {
            NavigationButtonLabel(text: text, systemImage: systemImage, sizeText: sizeText, inversed: inversed, width: width, height: height)
                .labelStyle(InversedLabel())
        }
    }
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(text: "Text", systemImage: "drop", sizeText: 30, inversed: false, width: 150, height: 50)
    }
}
