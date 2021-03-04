//
//  DetailButtons.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct DetailButtons: View {
    @Binding var showDrawingView: Bool
    var kana: Kana
    var kanaLabel: String
    var sizeText: CGFloat
    
    var body: some View {
        HStack {
            Button(action: {
                hapticFeedback(style: .soft)
                kana.readTextInJapanese(text: kanaLabel)
            }, label: {
                DetailButtonLabel(text: "Listen", sizeText: sizeText, systemImage: "speaker.wave.2")
            })
            Button(action: {
                hapticFeedback(style: .soft)
                showDrawingView.toggle()
            }, label: {
                DetailButtonLabel(text: "Write", sizeText: sizeText, systemImage: "hand.draw")
            })
        }
    }
}

struct DetailButtons_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        DetailButtons(showDrawingView: .constant(false), kana: modelData.kanas[0], kanaLabel: "", sizeText: 20)
            .previewLayout(.sizeThatFits)
    }
}
