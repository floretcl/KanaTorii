//
//  DrawingArea.swift
//  Kana Torii
//
//  Created by Clément FLORET on 20/01/2021.
//

import SwiftUI
import CoreGraphics

struct Drawing: Identifiable {
  var id: UUID = UUID()
  var path = Path()
  var points: [CGPoint] = []
  var color: Color = .primary
  
  mutating func addLine(to point: CGPoint, color: Color) {
    if path.isEmpty {
      path.move(to: point)
      self.color = color
    } else {
      path.addLine(to: point)
    }
    points.append(point)
  }
}

struct DrawingArea: View {
    @Binding var drawing: Drawing
    @Binding var paths: [Drawing]
    @Binding var image: UIImage
    @State var color: Color
    @State var lineWidth: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let heightDevice = geometry.size.height
            let widthDevice = geometry.size.width
            ZStack {
                Color(UIColor.systemBackground)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ stroke in
                        let currentPoint = stroke.location
                        if currentPoint.y >= 0 &&
                            currentPoint.x >= 0 &&
                            currentPoint.x < widthDevice
                            && currentPoint.y < heightDevice {
                            self.drawing.addLine(to: stroke.location,
                                                     color: color)
                        }
                    })
                    .onEnded({ stroke in
                        if !self.drawing.path.isEmpty {
                          self.paths.append(self.drawing)
                        }
                        self.drawing = Drawing()
                        image = self.takeScreenshot(origin: geometry.frame(in: .global).origin, size: geometry.size)
                    })
            )
            ForEach(paths) { drawingPaths in
                drawingPaths.path
                    .stroke(drawingPaths.color, style: StrokeStyle(lineWidth: self.lineWidth, lineCap: .round, lineJoin: .round, miterLimit: 10, dash: [CGFloat](), dashPhase: 0))
            }
            drawing.path.stroke(self.color, style: StrokeStyle(lineWidth: self.lineWidth, lineCap: .round, lineJoin: .round, miterLimit: 10, dash: [CGFloat](), dashPhase: 0))
        }
    }
}

struct DrawingArea_Previews: PreviewProvider {
    static var previews: some View {
        DrawingArea(drawing: .constant(Drawing()), paths: .constant([Drawing]()), image: .constant(UIImage()), color: .primary, lineWidth: 10)
    }
}
