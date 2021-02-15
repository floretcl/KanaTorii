//
//  DrawingAreaUIKit.swift
//  KanaTorii
//
//  Created by Clément FLORET on 15/02/2021.
//

import SwiftUI

struct DrawingAreaUIKit: View {
    @State var drawingImage: UIImage?
    @State var color: UIColor
    @State var linewidth: CGFloat
    
    var body: some View {
        ZStack {
            DrawingAreaRepresentation(drawingImage: $drawingImage, color: color, lineWidth: linewidth)
        }
    }
}

struct DrawingAreaUIKit_Previews: PreviewProvider {
    static var previews: some View {
        DrawingAreaUIKit(color: .black, linewidth: 20)
    }
}
