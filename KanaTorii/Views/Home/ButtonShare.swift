//
//  ButtonShare.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct ButtonShare: View {
    @Binding var showShare: Bool

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            self.showShare = true
        }, label: {
            HStack {
                Label("Share", systemImage: "square.and.arrow.up")
                    .foregroundColor(.white)
                if #available(iOS 15.0, *) {
                    Text("Share")
                        .foregroundColor(.white)
                }
            }.padding()
        })
    }
}

struct ButtonShare_Previews: PreviewProvider {
    static var previews: some View {
        ButtonShare(showShare: .constant(false))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
