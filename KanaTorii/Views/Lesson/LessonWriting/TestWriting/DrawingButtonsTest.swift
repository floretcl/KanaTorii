//
//  DrawingButtonsTest.swift
//  KanaTorii
//
//  Created by Clément FLORET on 19/02/2021.
//

import SwiftUI

struct DrawingButtonsTest: View {
    @StateObject var test: TestDrawing

    @Binding var drawings: [Drawing]
    @Binding var showGuide: Bool

    var sizeText: CGFloat
    var width: CGFloat
    var height: CGFloat
    var widthSpace: CGFloat

    var body: some View {
        HStack {
            if test.numberOfTestsPerformed == 0 {
                Spacer()
                Button(action: {
                    hapticFeedback(style: .soft)
                    showGuide.toggle()
                }, label: {
                    HStack {
                        Label(showGuide ? "Hide guide" : "Show guide", systemImage: showGuide ? "eye.slash" : "eye")
                            .font(.system(size: self.sizeText))
                            .foregroundColor(.accentColor)
                            .background(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke()
                                    .foregroundColor(.accentColor)
                                    .frame(width: width, height: height, alignment: .center)
                        )
                    }.frame(width: width, height: height, alignment: .center)
                }).padding(.vertical, 10)
                HStack{}
                    .frame(width: widthSpace)
            } else {
                Spacer()
            }
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
            .animation(.linear)
            Spacer()
        }
    }
}

struct DrawingButtonsTest_Previews: PreviewProvider {
    static var previews: some View {
        DrawingButtonsTest(
            test: TestDrawing(type: .hiragana, kana: "あ", romaji: "a"),
            drawings: .constant([Drawing]()),
            showGuide: .constant(true),
            sizeText: 20,
            width: 130,
            height: 60,
            widthSpace: 50
        )
        .previewLayout(.sizeThatFits)
    }
}
