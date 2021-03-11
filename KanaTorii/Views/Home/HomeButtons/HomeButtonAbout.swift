//
//  HomeButtonAbout.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct HomeButtonAbout: View {
    var width: CGFloat
    var heightPadding: CGFloat
    var sizeText: CGFloat
    
    var body: some View {
        Text("About")
            .font(.custom("YuMincho", size: sizeText))
            .frame(width: width)
            .shadow(color: Color.black, radius: 4, x: 0.0, y: 2.0)
            .padding(.vertical, heightPadding)
            .background(Color("Green"))
            .cornerRadius(50.0)
            .foregroundColor(.white)
    }
}

struct HomeButtonAbout_Previews: PreviewProvider {
    static var previews: some View {
        HomeButtonAbout(
                   width: 180.0,
                   heightPadding: 14.0,
                   sizeText: 21)
            .previewLayout(.sizeThatFits)
    }
}
