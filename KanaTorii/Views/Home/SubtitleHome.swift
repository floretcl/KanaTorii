//
//  SubtitleHome.swift
//  Kana Torii
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct SubtitleHome: View {
    var body: some View {
        Text("Learn Hiragana and Katakana\n in a simple and effective way")
            .foregroundColor(.white)
            .padding()
    }
}

struct SubtitleHome_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleHome()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
