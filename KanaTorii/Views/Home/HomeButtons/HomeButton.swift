//
//  HomeButton.swift
//  KanaTorii
//
//  Created by Clément FLORET on 08/03/2021.
//

import SwiftUI

struct HomeButton: View {
    var textButton: String
    var width: CGFloat
    var heightPadding: CGFloat
    var sizeText: CGFloat
    
    var body: some View {
        Text(textButton)
            .font(.custom("YuMincho", size: sizeText))
            .frame(width: width)
            .shadow(color: Color.black, radius: 4, x: 0.0, y: 2.0)
            .padding(.vertical, heightPadding)
            .background(Color("Green"))
            .cornerRadius(50.0)
            .foregroundColor(.white)
    }
}

struct HomeButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeButton(textButton: "Placeholder",
                   width: 180.0,
                   heightPadding: 14.0,
                   sizeText: 21)
            .previewLayout(.sizeThatFits)
    }
}
