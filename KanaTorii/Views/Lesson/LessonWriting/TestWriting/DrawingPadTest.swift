//
//  DrawingPadTest.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct DrawingPadTest: View {
    @Binding var drawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var image: UIImage
    var lineWidth: CGFloat

    var romaji: String
    var kanaType: String
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
                GuideTest(romaji: romaji, kanaType: kanaType)
            }
            DrawingGrid()
        }
    }
}

struct DrawingPadTest_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPadTest(drawing: .constant(Drawing()), drawings: .constant([Drawing]()), image: .constant(UIImage()), lineWidth: 20, romaji: "a", kanaType: "hiragana", showGuide: true)
    }
}
