//
//  VerticalDottedLine.swift
//  Kana Torii
//
//  Created by Clément FLORET on 19/01/2021.
//

import SwiftUI

struct VerticalDottedLine: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.width/2, y: 0))
            path.addLine(to: CGPoint(x: rect.width/2, y: rect.height))
            return path
        }
}
