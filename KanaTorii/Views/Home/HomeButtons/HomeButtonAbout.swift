//
//  HomeButtonAbout.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct HomeButtonAbout: View {
    var heightPadding: CGFloat
    var sizeText: CGFloat

    var body: some View {
        Text("About")
            .font(.custom("YuMincho", size: sizeText))
            .foregroundColor(.white)
            .padding(.vertical, heightPadding)
            .padding(.horizontal, 50)
            .shadow(color: Color.black, radius: 4, x: 0.0, y: 2.0)
            .background(Color("Green"))
            .cornerRadius(50.0)
    }
}

struct HomeButtonAbout_Previews: PreviewProvider {
    static var previews: some View {
        HomeButtonAbout(
                   heightPadding: 14.0,
                   sizeText: 21)
            .previewLayout(.sizeThatFits)
    }
}
