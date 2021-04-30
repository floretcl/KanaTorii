//
//  Chevron.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/01/2021.
//

import SwiftUI

struct Chevron: View {
    var label: String
    var heightDevice: CGFloat

    var body: some View {
        Image(systemName: label)
            .font(.largeTitle)
            .padding(.horizontal, 15)
            .padding(.vertical, heightDevice/12)
    }
}

struct Chevron_Previews: PreviewProvider {
    static var previews: some View {
        Chevron(label: "chevron.right", heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
