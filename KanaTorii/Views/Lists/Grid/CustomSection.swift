//
//  CustomSection.swift
//  Kana Torii
//
//  Created by Clément FLORET on 03/01/2021.
//

import SwiftUI

struct CustomSection: View {
    var label: String

    var body: some View {
        HStack {
            Spacer()
            Text(label)
                .font(.custom("YuMincho", size: 20))
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .padding(15)
                .shadow(color: Color.black, radius: 3, x: 1.0, y: 3.0)
            Spacer()
        }.background(Color("Green"))
    }
}

struct CustomSection_Previews: PreviewProvider {
    static var previews: some View {
        CustomSection(label: "Gojuon")
            .previewLayout(.sizeThatFits)
    }
}
