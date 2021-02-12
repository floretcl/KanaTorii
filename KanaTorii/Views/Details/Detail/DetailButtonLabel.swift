//
//  DetailButtonLabel.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/01/2021.
//

import SwiftUI

struct DetailButtonLabel: View {
    var text: String
    var sizeText: CGFloat
    var systemImage: String
    
    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.system(size: sizeText))
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .background(Color.orange)
            .cornerRadius(30.0)
            .padding(.horizontal, 6)
    }
}

struct DetailButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        DetailButtonLabel(text: "Write", sizeText: 20, systemImage: "hand.draw")
            .previewLayout(.sizeThatFits)
    }
}
