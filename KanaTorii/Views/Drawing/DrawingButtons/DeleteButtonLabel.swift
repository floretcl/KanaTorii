//
//  DeleteButtonLabel.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct DeleteButtonLabel: View {
    var sizeText: CGFloat
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        Label("Delete", systemImage: "trash")
            .font(.system(size: self.sizeText))
            .foregroundColor(.red)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke()
                    .foregroundColor(.red)
                    .frame(width: self.width, height: self.height, alignment: .center)
            )
    }
}

struct DeleteButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButtonLabel(sizeText: 20, width: 129, height: 35)
    }
}
