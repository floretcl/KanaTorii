//
//  WritingArea.swift
//  Kana Torii
//
//  Created by Clément FLORET on 20/01/2021.
//

import SwiftUI
import CoreGraphics

struct WritingArea: View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]
    @State var color: Color
    @State var lineWidth: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let heightDevice = geometry.size.height
            let widthDevice = geometry.size.width
            // Dans un tableau de lignes, pour chaque ligne
            Path { path in
                // pour chaque point dans le tableau de points sauvegardé
                for drawing in self.drawings {
                    // Ajouter une ligne avec le point sauvegardé
                    self.add(drawing: drawing, toPath: &path)
                }
                // Ajouter une ligne avec le point en cours
                self.add(drawing: self.currentDrawing, toPath: &path)
            }
            // réglage de couleurs du "contour de chaque point du tableau de lignes
            // Contour arrondi
            .stroke(self.color, style: StrokeStyle(lineWidth: self.lineWidth, lineCap: .round, lineJoin: .round, miterLimit: 10, dash: [CGFloat](), dashPhase: 0))
            .background(Color(UIColor.systemBackground))
                .gesture(
                    // A un déplacement minimum de 0.1
                    DragGesture(minimumDistance: 0.1)
                        // pendant le drag gesture, pour chaque valeur
                        .onChanged({ (value) in
                            let currentPoint = value.location
                            // si le point courant est dans la zone
                            if currentPoint.y >= 0 &&
                                currentPoint.x >= 0 &&
                                currentPoint.x < widthDevice
                                && currentPoint.y < heightDevice {
                                self.currentDrawing.points.append(currentPoint)
                            }
                        })
                        // A la fin du drag gesture ajoute la ligne en cours
                        // au dessin et nettoie
                        .onEnded({ (value) in
                            self.drawings.append(self.currentDrawing)
                            self.currentDrawing = Drawing()
                        })
                )
        }
        .padding()
    }
    private func add(drawing: Drawing, toPath path: inout Path) {
            let points = drawing.points
            if points.count > 1 {
                for i in 0..<points.count-1 {
                    let current = points[i]
                    let next = points[i+1]
                    path.move(to: current)
                    path.addLine(to: next)
                }
            }
        }
}
struct Drawing {
    var points: [CGPoint] = [CGPoint]()
}

struct WritingArea_Previews: PreviewProvider {
    static var previews: some View {
        WritingArea(currentDrawing: .constant(Drawing()), drawings: .constant([Drawing]()), color: .orange, lineWidth: 10)
    }
}
