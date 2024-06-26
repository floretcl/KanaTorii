//
//  DrawingButtonQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 25/02/2021.
//

import SwiftUI

struct DrawingButtonQuiz: View {
    @Binding var drawings: [Drawing]

    var sizeText: CGFloat
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                hapticFeedback(style: .soft)
                drawings = [Drawing]()
            }, label: {
                HStack {
                    Label("Delete", systemImage: "trash")
                        .font(.system(size: self.sizeText))
                        .foregroundColor(.red)
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke()
                                .foregroundColor(.red)
                                .frame(width: width, height: height, alignment: .center)
                    )
                }.frame(width: width, height: height, alignment: .center)
            })
            .padding(.vertical, 10)
            Spacer()
        }
    }
}

struct DrawingButtonQuiz_Previews: PreviewProvider {
    static var previews: some View {
        DrawingButtonQuiz(
            drawings: .constant([Drawing]()),
            sizeText: 20,
            width: 130,
            height: 60
        )
        .previewLayout(.sizeThatFits)
    }
}
