//
//  SoundImage.swift
//  Kana Torii
//
//  Created by Clément FLORET on 02/02/2021.
//

import SwiftUI

struct SoundImage: View {
    var sizeText: CGFloat
    
    var body: some View {
        Image(systemName: "speaker.wave.2.fill")
            .font(.system(size: sizeText))
            .foregroundColor(.accentColor)
            .padding(5)
    }
}

struct SoundImage_Previews: PreviewProvider {
    static var previews: some View {
        SoundImage(sizeText: 20)
            .previewLayout(.sizeThatFits)
    }
}
