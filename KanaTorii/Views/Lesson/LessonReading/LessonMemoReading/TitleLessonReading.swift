//
//  TitleLessonReading.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct TitleLessonReading: View {
    var heightDevice: CGFloat

    var body: some View {
        Text("Memorize the shape and pronunciation of this kana")
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleLessonReading_Previews: PreviewProvider {
    static var previews: some View {
        TitleLessonReading(heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
