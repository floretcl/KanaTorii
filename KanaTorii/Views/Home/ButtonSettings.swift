//
//  ButtonSettings.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct ButtonSettings: View {
    @Binding var showSettings: Bool

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            self.showSettings.toggle()
        }, label: {
            HStack {
                Text("Settings")
                    .foregroundColor(.white)
                Image(systemName: "gearshape")
                    .foregroundColor(.white)
            }.padding()
        })
    }
}

struct ButtonSettings_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSettings(showSettings: .constant(false))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
