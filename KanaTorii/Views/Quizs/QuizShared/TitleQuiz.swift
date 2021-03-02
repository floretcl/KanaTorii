//
//  TitleQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 25/02/2021.
//

import SwiftUI

struct TitleQuiz: View {
    var heightDevice: CGFloat
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleQuiz_Previews: PreviewProvider {
    static var previews: some View {
        TitleQuiz(heightDevice: 800, text: "Memorize the shape and pronunciation of this kana")
            .previewLayout(.sizeThatFits)
    }
}
