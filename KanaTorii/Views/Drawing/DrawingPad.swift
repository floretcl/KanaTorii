//
//  DrawingPad.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct DrawingPad: View {
    @State var drawing: Drawing
    @State var drawings: [Drawing]
    var lineWidth: CGFloat
    var kana: Kana
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
                Guide(kana: kana, kanaType: kanaType)
            }
            DrawingGrid()
        }
    }
}

struct DrawingPad_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        DrawingPad(drawing: Drawing(), drawings: [Drawing](), lineWidth: 20, kana: modelData.kanas[100], kanaType: "hiragana", showGuide: true)
    }
}
