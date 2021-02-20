//
//  CanvasUIKit.swift
//  KanaTorii
//
//  Created by Clément FLORET on 15/02/2021.
//

import Foundation
import UIKit

class CanvasUIKit: UIControl {
    var drawingImage: UIImage?
    var drawColor: UIColor
    var lineWidth: CGFloat
    
    init(color: UIColor, drawingImage: UIImage?, lineWidth: CGFloat) {
        self.drawingImage = drawingImage
        self.drawColor = color
        self.lineWidth = lineWidth
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawingImage?.draw(in: rect)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        let renderer = UIGraphicsImageRenderer(size: bounds.size, format: format)
        drawingImage = renderer.image { context in
            UIColor(white: 1, alpha: 0.1).setFill()
            context.fill(bounds)
            drawingImage?.draw(in: bounds)
            drawStroke(context: context.cgContext, touch: touch)
            setNeedsDisplay()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendActions(for: .valueChanged)
    }
    private func drawStroke(context: CGContext, touch: UITouch) {
        let previousLocation = touch.previousLocation(in: self)
        let location = touch.location(in: self)
        
        context.setLineWidth(lineWidth)
        context.setStrokeColor(drawColor.cgColor)
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        
        context.move(to: previousLocation)
        context.addLine(to: location)
        context.strokePath()
    }
}
