//
//  HomeJapaneseTitle.swift
//  Kana Torii
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct HomeJapaneseTitle: View {
    var sizeText: CGFloat

    var body: some View {
        Text("かな 鳥居")
            .font(.custom("YuMincho", size: sizeText))
            .fontWeight(.semibold)
            .foregroundColor(Color(red: 0.70, green: 0.37, blue: 0.17, opacity: 1.0))
            .shadow(color: Color.black.opacity(0.85),
                    radius: 2, x: 0.0, y: 2.0)
    }
}

struct HomeJapaneseTitle_Previews: PreviewProvider {
    static var previews: some View {
        HomeJapaneseTitle(sizeText: 40)
            .previewLayout(.sizeThatFits)
    }
}
