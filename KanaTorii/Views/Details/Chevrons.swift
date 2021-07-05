//
//  Chevrons.swift
//  Kana Torii
//
//  Created by Clément FLORET on 15/01/2021.
//

import SwiftUI

struct Chevrons: View {

    var body: some View {
        GeometryReader(content: { geometry in
            let heightDevice = geometry.size.height
            VStack(alignment: .center, spacing: 0, content: {
                Spacer()
                HStack {
                    Chevron(label: "chevron.left", heightDevice: heightDevice)
                    Spacer()
                    Chevron(label: "chevron.right", heightDevice: heightDevice)
                }
                Spacer()
            })
        })
    }
}

struct Chevrons_Previews: PreviewProvider {
    static var previews: some View {
        Chevrons()
    }
}
