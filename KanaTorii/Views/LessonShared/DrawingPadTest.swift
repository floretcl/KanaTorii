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
    var lineWidth: CGFloat
    var romaji: String
    var kanaType: String
    var showGuide: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous)
            .foregroundColor(Color(UIColor.systemBackground))
            .shadow(color: Color("Shadow"), radius: 10, x: 0, y: 0)
            DrawingArea(
                drawing: $drawing,
                paths: $drawings,
                color: .primary,
                lineWidth: lineWidth)
            if showGuide {
                GuideTest(romaji: romaji, kanaType: kanaType)
            }
            DrawingGrid()
        }
    }
}

struct DrawingPadTest_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPadTest(drawing: .constant(Drawing()), drawings: .constant([Drawing]()), lineWidth: 20, romaji: "a", kanaType: "hiragana", showGuide: true)
    }
}
