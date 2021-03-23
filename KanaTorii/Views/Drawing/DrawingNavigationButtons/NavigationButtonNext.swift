//
//  NavigationButtonNext.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct NavigationButtonNext: View {
    var systemImage: String
    var sizeText: CGFloat
    var inversed: Bool
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Label("Next", systemImage: systemImage)
            .labelStyle(InversedLabel())
            .font(.system(size: sizeText))
            .foregroundColor(.white)
            .frame(minWidth: 80, maxWidth: width, minHeight: 20, maxHeight: height, alignment: .center)
            .background(Color.orange)
            .cornerRadius(30.0)
            .padding(.horizontal, 6)
    }
}

struct NavigationButtonNext_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButtonPrevious(systemImage: "drop", sizeText: 30, inversed: false, width: 150, height: 50)
            .previewLayout(.sizeThatFits)
    }
}
