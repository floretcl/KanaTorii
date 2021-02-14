//
//  ExtensionsPath.swift
//  KanaTorii
//
//  Created by Clément FLORET on 13/02/2021.
//

import SwiftUI
import CoreGraphics

extension Path {
    mutating func interpolatePoints(interpolationPoints: [CGPoint], alpha: CGFloat = 1.0/3.0) {
        guard !interpolationPoints.isEmpty else { return }
        self.move(to: interpolationPoints[0])
        
        for index in 0..<interpolationPoints.count - 1 {
            var currentPoint: CGPoint = interpolationPoints[index]
            var nextIndex: Int = (index + 1) % interpolationPoints.count
            var previousIndex: Int = index == 0 ? interpolationPoints.count - 1 : index - 1
            var previousPoint: CGPoint = interpolationPoints[previousIndex]
            var nextPoint: CGPoint = interpolationPoints[nextIndex]
            let endPoint: CGPoint = nextPoint
            var mx: CGFloat
            var my: CGFloat
          
            if index > 0 {
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }
            else {
                mx = (nextPoint.x - currentPoint.x) / 2.0
                my = (nextPoint.y - currentPoint.y) / 2.0
            }
            let controlPoint1: CGPoint = CGPoint(x: currentPoint.x + mx * alpha, y: currentPoint.y + my * alpha)
            
            currentPoint = interpolationPoints[nextIndex]
            nextIndex = (nextIndex + 1) % interpolationPoints.count
            previousIndex = index
            previousPoint = interpolationPoints[previousIndex]
            nextPoint = interpolationPoints[nextIndex]
            if index < interpolationPoints.count - 2 {
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }
            else {
                mx = (currentPoint.x - previousPoint.x) / 2.0
                my = (currentPoint.y - previousPoint.y) / 2.0
            }
            let controlPoint2 = CGPoint(x: currentPoint.x - mx * alpha, y: currentPoint.y - my * alpha)
            
            self.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
        }
    }
}

extension UIBezierPath {
    func interpolatePoints(interpolationPoints: [CGPoint], alpha: CGFloat = 1.0/3.0) {
        guard !interpolationPoints.isEmpty else { return }
        self.move(to: interpolationPoints[0])
        
        for index in 0..<interpolationPoints.count - 1 {
            var currentPoint: CGPoint = interpolationPoints[index]
            var nextIndex: Int = (index + 1) % interpolationPoints.count
            var previousIndex: Int = index == 0 ? interpolationPoints.count - 1 : index - 1
            var previousPoint: CGPoint = interpolationPoints[previousIndex]
            var nextPoint: CGPoint = interpolationPoints[nextIndex]
            let endPoint: CGPoint = nextPoint
            var mx: CGFloat
            var my: CGFloat
          
            if index > 0 {
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }
            else {
                mx = (nextPoint.x - currentPoint.x) / 2.0
                my = (nextPoint.y - currentPoint.y) / 2.0
            }
            let controlPoint1: CGPoint = CGPoint(x: currentPoint.x + mx * alpha, y: currentPoint.y + my * alpha)
            
            currentPoint = interpolationPoints[nextIndex]
            nextIndex = (nextIndex + 1) % interpolationPoints.count
            previousIndex = index
            previousPoint = interpolationPoints[previousIndex]
            nextPoint = interpolationPoints[nextIndex]
            if index < interpolationPoints.count - 2 {
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }
            else {
                mx = (currentPoint.x - previousPoint.x) / 2.0
                my = (currentPoint.y - previousPoint.y) / 2.0
            }
            let controlPoint2 = CGPoint(x: currentPoint.x - mx * alpha, y: currentPoint.y - my * alpha)
            
            self.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
    }
}
