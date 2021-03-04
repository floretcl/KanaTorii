//
//  ButtonLabel.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct ButtonLabel: View {
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: textSize))
            .padding(.horizontal, widthDevice/8)
            .padding(.vertical, heightDevice/50)
            .foregroundColor(.white)
            .background(Color.orange)
            .clipShape(Capsule())
    }
}

struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(widthDevice: 300, heightDevice: 600, textSize: 20, text: "Continue")
            .previewLayout(.sizeThatFits)
    }
}
