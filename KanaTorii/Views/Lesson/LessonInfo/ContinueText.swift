//
//  ContinueText.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/03/2021.
//

import SwiftUI

struct ContinueText: View {
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat
    
    var body: some View {
        Text("Continue")
            .font(.system(size: textSize))
            .padding(.horizontal, widthDevice/8)
            .padding(.vertical, heightDevice/50)
            .foregroundColor(.white)
            .background(Color.orange)
            .clipShape(Capsule())
    }
}

struct ContinueText_Previews: PreviewProvider {
    static var previews: some View {
        ContinueText(widthDevice: 300, heightDevice: 600, textSize: 33)
            .previewLayout(.sizeThatFits)
    }
}
