//
//  DetailButtons.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct DetailButtons: View {
    var kana: Kana
    var kanaLabel: String
    var sizeText: CGFloat
    @Binding var showDrawingView: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                hapticFeedback(style: .soft)
                Kana.readTextInJapanese(text: kanaLabel)
            }, label: {
                Label("Listen", systemImage: "speaker.wave.2")
                    .font(.system(size: sizeText))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 14)
                    .background(Color.orange)
                    .cornerRadius(30.0)
                    .padding(.horizontal, 6)
            })
            Button(action: {
                hapticFeedback(style: .soft)
                showDrawingView.toggle()
            }, label: {
                Label("Write", systemImage: "hand.draw")
                    .font(.system(size: sizeText))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 14)
                    .background(Color.orange)
                    .cornerRadius(30.0)
                    .padding(.horizontal, 6)
            })
        }
    }
}

struct DetailButtons_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        DetailButtons(kana: modelData.kanas[0], kanaLabel: "", sizeText: 20, showDrawingView: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
