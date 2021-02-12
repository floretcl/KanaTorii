//
//  LinesImagesSection.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/01/2021.
//

import SwiftUI

struct LinesImagesSection: View {
    var linesOrderImage: String
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var sizeText: CGFloat
    
    var body: some View {
        VStack {
            Text("Line writing order")
                .font(.system(size: sizeText))
            Image("\(linesOrderImage)")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(.vertical)
        .padding(.horizontal, widthDevice/10)
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(7)
        .shadow(color: Color.black.opacity(0.1), radius: 29, x: 0.0, y: 0.0)
    }
}

struct LinesImagesSection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LinesImagesSection(linesOrderImage: "linesHiraganaA", widthDevice: 400, heightDevice: 800, sizeText: 28)
        }
    }
}
