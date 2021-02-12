//
//  HomeTitle.swift
//  Kana Torii
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct HomeTitle: View {
    var sizeText: CGFloat
    
    var body: some View {
        Text("Kana Torii")
            .font(.system(size: sizeText))
            .fontWeight(.regular)
            .foregroundColor(Color.white)
            .shadow(color: Color.black.opacity(0.5),
                    radius: 2, x: 0.0, y: 2.0)
    }
}

struct HomeTitle_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitle(sizeText: 52.0)
            .previewLayout(.sizeThatFits)
    }
}
