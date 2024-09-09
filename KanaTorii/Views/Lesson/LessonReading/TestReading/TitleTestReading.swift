//
//  TitleTestReading.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct TitleTestReading: View {
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

struct TitleTestReading_Previews: PreviewProvider {
    static var previews: some View {
        TitleTestReading(heightDevice: 800)
            .previewLayout(.sizeThatFits)
    }
}
