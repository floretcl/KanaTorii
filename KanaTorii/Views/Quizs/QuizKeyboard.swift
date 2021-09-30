//
//  QuizKeyboard.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizKeyboard: View {

    @StateObject var quiz: Quiz
    @State var text: String = ""

    @State var showActionSheet: Bool = false
    @Binding var showScore: Bool

    @State var widthDeviceSaved: CGFloat = 0
    @State var heightDeviceSaved: CGFloat = 0

    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            if UIDevice.current.localizedModel == "iPad" {
                BodyQuizKeyboard(
                    quiz: quiz,
                    text: $text,
                    showActionSheet: $showActionSheet,
                    showScore: $showScore,
                    widthDeviceSaved: $widthDeviceSaved,
                    heightDeviceSaved: $heightDeviceSaved)
                .background(Color(UIColor.secondarySystemBackground))
                .onAppear(perform: {
                    widthDeviceSaved = widthDevice
                    heightDeviceSaved = heightDevice
                })

            } else {
                BodyQuizKeyboard(
                    quiz: quiz,
                    text: $text,
                    showActionSheet: $showActionSheet,
                    showScore: $showScore,
                    widthDeviceSaved: $widthDeviceSaved,
                    heightDeviceSaved: $heightDeviceSaved)
                .background(Color(UIColor.secondarySystemBackground))
                .edgesIgnoringSafeArea(.bottom)
                .onAppear(perform: {
                    widthDeviceSaved = widthDevice
                    heightDeviceSaved = heightDevice
                })
            }
        })
    }
}

struct QuizKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuizKeyboard(
                quiz: Quiz(
                    quickQuiz: true,
                    difficulty: .hard,
                    direction: .toRomaji,
                    hiragana: true,
                    katakana: false,
                    kanaSection: .all,
                    nbQuestions: 10.0),
                showScore: .constant(false)
            ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
