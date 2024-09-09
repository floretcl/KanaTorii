//
//  CustomCircularProgressView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 07/10/2021.
//

import SwiftUI

struct CustomCircularProgressView: View {
    var progress: Float
    var progressColor: Color
    var size: CGFloat
    var sizeText: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 7.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress/100, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(progressColor)
                .rotationEffect(Angle(degrees: 270.0))
            Text(String(format: "%.0f %%", min(progress, 100.0)))
                .font(.system(size: sizeText))
                .bold()
        }.frame(width: size, height: size, alignment: .center)
            .padding(5)
    }
}

struct CustomCircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCircularProgressView(progress: 100, progressColor: Color.red, size: 65, sizeText: 18)
            .previewLayout(.sizeThatFits)
    }
}
