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
            self.showShare = true
        }, label: {
            Label("Share", systemImage: "square.and.arrow.up")
                .foregroundColor(.white)
                .padding()
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
