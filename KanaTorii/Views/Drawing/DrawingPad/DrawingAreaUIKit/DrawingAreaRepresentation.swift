//
//  DrawingAreaRepresentation.swift
//  KanaTorii
//
//  Created by Clément FLORET on 15/02/2021.
//

import Foundation
import SwiftUI

struct DrawingAreaRepresentation: UIViewRepresentable {
    @Binding var drawingImage: UIImage?
    let color: UIColor
    let lineWidth: CGFloat
    
    func makeCoordinator() -> Coordinator {
        Coordinator(drawingImage: $drawingImage)
    }
    
    func makeUIView(context: Context) -> CanvasUIKit {
        let view = CanvasUIKit(color: color, drawingImage: drawingImage, lineWidth: lineWidth)
        view.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateDrawingImage(sender:)),
            for: .valueChanged)
        return view
    }
    func updateUIView(_ uiView: CanvasUIKit, context: Context) {
        uiView.drawColor = color
        //uiView.lineWidth = lineWidth
    }
    
    class Coordinator: NSObject {
        @Binding var drawingImage: UIImage?

        init(drawingImage: Binding<UIImage?>) {
            _drawingImage = drawingImage
        }

        @objc
        func updateDrawingImage(sender: CanvasUIKit) {
            self.drawingImage = sender.drawingImage
        }
    }
}
