//
//  ContinueLabel.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct ContinueLabel: View {
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var body: some View {
        Text("Continue")
            .padding(.horizontal, widthDevice/8)
            .padding(.vertical, heightDevice/50)
            .foregroundColor(.white)
            .background(Color.orange)
            .clipShape(Capsule())
    }
}

struct ContinueLabel_Previews: PreviewProvider {
    static var previews: some View {
        ContinueLabel(widthDevice: 300, heightDevice: 600)
            .previewLayout(.sizeThatFits)
    }
}
