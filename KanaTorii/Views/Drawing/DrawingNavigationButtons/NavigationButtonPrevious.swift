//
//  NavigationButtonPrevious.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct NavigationButtonPrevious: View {
    var systemImage: String
    var sizeText: CGFloat
    var inversed: Bool
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        if inversed != true {
            Label("Previous", systemImage: systemImage)
                .font(.system(size: sizeText))
                .foregroundColor(.white)
                .frame(minWidth: 80, maxWidth: width, minHeight: 20, maxHeight: height, alignment: .center)
                .background(Color.orange)
                .cornerRadius(30.0)
                .padding(.horizontal, 6)
        } else {
            Label("Previous", systemImage: systemImage)
                .font(.system(size: sizeText))
                .foregroundColor(.white)
                .frame(minWidth: 80, maxWidth: width, minHeight: 20, maxHeight: height, alignment: .center)
                .background(Color.orange)
                .cornerRadius(30.0)
                .padding(.horizontal, 6)
        }
    }
}

struct NavigationButtonPrevious_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButtonPrevious(systemImage: "drop", sizeText: 30, inversed: false, width: 150, height: 50)
            .previewLayout(.sizeThatFits)
    }
}
