//
//  ShowGuideButtonLabel.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct ShowGuideButtonLabel: View {
    var sizeText: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Text("Show guide")
            .font(.system(size: self.sizeText))
            .foregroundColor(.accentColor)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke()
                    .foregroundColor(.accentColor)
                    .frame(width: self.width, height: self.height, alignment: .center)
            )
    }
}

struct ShowGuideButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ShowGuideButtonLabel(sizeText: 20, width: 129, height: 35)
    }
}
