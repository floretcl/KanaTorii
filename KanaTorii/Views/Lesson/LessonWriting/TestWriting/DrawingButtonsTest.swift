//
//  DrawingButtonsTest.swift
//  KanaTorii
//
//  Created by Clément FLORET on 19/02/2021.
//

import SwiftUI

struct DrawingButtonsTest: View {
    @Binding var drawings: [Drawing]
    @Binding var showGuide: Bool
    @ObservedObject var test: TestDrawing
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
            drawings: .constant([Drawing]()),
            showGuide: .constant(true),
            test: TestDrawing(type: .hiragana, kana: "あ", romaji: "a"),
            sizeText: 20,
            width: 130,
            height: 60
        )
        .previewLayout(.sizeThatFits)
    }
}
