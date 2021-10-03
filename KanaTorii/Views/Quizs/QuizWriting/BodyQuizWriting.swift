//
//  BodyQuizWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 23/03/2021.
//

import SwiftUI

struct BodyQuizWriting: View {
    @StateObject var quiz: Quiz
    private var kanaType: String {
        if quiz.hiragana {
            return "hiragana"
        } else {
            return "katakana"
        }
    }

    @Binding var drawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var image: UIImage

    var widthDevice: CGFloat
    var heightDevice: CGFloat

    @Binding var showActionSheet: Bool

    var body: some View {
        ZStack {
            Spacer()
            VStack {
                TitleQuizWriting(quiz: quiz, kanaType: kanaType, heightDevice: heightDevice)
                if UIDevice.current.localizedModel == "iPad" {
                    Spacer()
                    DrawingPadQuiz(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: 15)
                        .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                        .padding(.all, heightDevice/40)
                    DrawingButtonQuiz(drawings: $drawings, sizeText: heightDevice/40, width: widthDevice/6, height: heightDevice/22)
                } else {
                    DrawingPadQuiz(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/40)
                        .frame(minWidth: 220, idealWidth: 300, maxWidth: 600, minHeight: 220, idealHeight: 300, maxHeight: 400, alignment: .center)
                        .padding(.all, heightDevice/40)
                    DrawingButtonQuiz(drawings: $drawings, sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                }
                Spacer()
                ContinueButtonQuizDrawing(
                    quiz: quiz,
                    drawings: $drawings,
                    image: $image,
                    widthDevice: widthDevice,
                    heightDevice: heightDevice,
                    textSize: heightDevice/40,
                    showActionSheet: $showActionSheet)
                    .padding(.bottom, 25)
            }
            Spacer()
        }
    }
}

struct BodyQuizWriting_Previews: PreviewProvider {
    static var previews: some View {
        BodyQuizWriting(
            quiz: Quiz(
                quickQuiz: true,
                difficulty: .hard,
                direction: .toKana,
                hiragana: false,
                katakana: true,
                kanaSection: .all,
                nbQuestions: 5.0),
            drawing: .constant(Drawing()),
            drawings: .constant([Drawing()]),
            image: .constant(UIImage()),
            widthDevice: 300,
            heightDevice: 800,
            showActionSheet: .constant(false))
    }
}
