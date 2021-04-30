//
//  TitleQuizMCQ.swift
//  KanaTorii
//
//  Created by Clément FLORET on 25/02/2021.
//

import SwiftUI

struct TitleQuizMCQ: View {
    var heightDevice: CGFloat

    var body: some View {
        Text("Find correct answer")
            .font(.system(size: heightDevice/35))
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .padding(.vertical, heightDevice/70)
            .padding(.horizontal, 20)
    }
}

struct TitleQuizMCQ_Previews: PreviewProvider {
    static var previews: some View {
        TitleQuizMCQ(heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
