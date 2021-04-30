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

    var body: some View {
        HStack {
            if test.numberOfTestsPerformed == 0 {
                Spacer()
                Button(action: {
                    hapticFeedback(style: .soft)
                    showGuide.toggle()
                }, label: {
                    ShowGuideButtonLabel(sizeText: sizeText, width: width, height: height)
                })
            }
            Spacer()
            Button(action: {
                hapticFeedback(style: .soft)
                drawings = [Drawing]()
            }, label: {
                DeleteButtonLabel(sizeText: sizeText, width: width, height: height)
            })
            .padding(.all, 10)
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
            height: 60
        )
        .previewLayout(.sizeThatFits)
    }
}
