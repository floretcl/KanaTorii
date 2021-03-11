//
//  TitleLessonWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct TitleLessonWriting: View {
    var heightDevice: CGFloat
    
    var body: some View {
        Text("Memorize the writing order of the lines and the shape of this kana")
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleLessonWriting_Previews: PreviewProvider {
    static var previews: some View {
        TitleLessonWriting(heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
