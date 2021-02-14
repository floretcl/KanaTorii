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
  
  mutating func smoothLine() {
    var newPath = Path()
    newPath.interpolatePoints(interpolationPoints: points)
    path = newPath
  }
  
}

struct DrawingArea: View {
    @Binding var drawing: Drawing
    @Binding var paths: [Drawing]
    @State var color: Color
    @State var lineWidth: CGFloat
    
    var body: some View {
        let dragGesture = DragGesture(minimumDistance: 0)
            .onChanged({ stroke in
                self.drawing.addLine(to: stroke.location,
                                         color: color)
            })
            .onEnded({ stroke in
                self.drawing.smoothLine()
                if !self.drawing.path.isEmpty {
                  self.paths.append(self.drawing)
                }
                self.drawing = Drawing()
            })
        return ZStack {
            Color(UIColor.systemBackground)
              .edgesIgnoringSafeArea(.all)
            .gesture(dragGesture)
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
        DrawingArea(drawing: .constant(Drawing()), paths: .constant([Drawing]()), color: .primary, lineWidth: 10)
    }
}
