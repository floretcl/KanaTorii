//
//  NavigationButtonLabel.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct NavigationButtonLabel: View {
    var text: String
    var systemImage: String
    var sizeText: CGFloat
    var inversed: Bool
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.system(size: sizeText))
            .foregroundColor(.white)
            .frame(minWidth: 80, maxWidth: width, minHeight: 20, maxHeight: height, alignment: .center)
            .background(Color.orange)
            .cornerRadius(30.0)
            .padding(.horizontal, 6)
    }
}

struct NavigationButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButtonLabel(text: "Previous", systemImage: "chevron.left", sizeText: 20, inversed: false, width: 120, height: 50)
            .previewLayout(.sizeThatFits)
    }
}
