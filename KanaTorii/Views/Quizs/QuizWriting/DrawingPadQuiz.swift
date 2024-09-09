//
//  DrawingPadQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 25/02/2021.
//

import SwiftUI

struct DrawingPadQuiz: View {
    @Binding var drawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var image: UIImage
    var lineWidth: CGFloat

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
            DrawingGrid()
        }
    }
}

struct DrawingPadQuiz_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPadQuiz(drawing: .constant(Drawing()), drawings: .constant([Drawing]()), image: .constant(UIImage()), lineWidth: 20)
    }
}
