//
//  DrawingPad.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct DrawingPad: View {
    var kana: Kana
    var kanaType: String
    @Binding var drawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var image: UIImage
    var lineWidth: CGFloat
    var showGuide: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: 25,
                style: .continuous)
            .foregroundColor(Color(UIColor.systemBackground))
            .shadow(color: Color("Shadow"), radius: 7, x: 0, y: 0)            
            DrawingArea(
                drawing: $drawing,
                paths: $drawings,
                image: $image,
                color: .primary,
                lineWidth: lineWidth)
                .cornerRadius(25)
            if showGuide {
                Guide(kana: kana, kanaType: kanaType)
            }
            DrawingGrid()
        }
    }
}

struct DrawingPad_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        DrawingPad(kana: modelData.kanas[100], kanaType: "hiragana", drawing: .constant(Drawing()), drawings: .constant([Drawing]()), image: .constant(UIImage()), lineWidth: 20, showGuide: true)
    }
}
