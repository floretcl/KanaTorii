//
//  QuizWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizWriting: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var quiz: Quiz

    @State var drawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var image: UIImage = UIImage()

    @Binding var showScore: Bool
    @State var showActionSheet: Bool = false

    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    QuizHeader(quiz: quiz, showScore: $showScore, heightDevice: heightDevice)
                        .padding(.top, 5)
                    BodyQuizWriting(
                        quiz: quiz,
                        drawing: $drawing,
                        drawings: $drawings,
                        image: $image,
                        widthDevice: widthDevice,
                        heightDevice: heightDevice,
                        showActionSheet: $showActionSheet)
                }.background(Color(UIColor.secondarySystemBackground))
                .alert(isPresented: $showActionSheet, content: {
                    Alert(title: Text("Your result: "),
                          message: quiz.correctAnswer ? Text("Right answer: \(quiz.currentSolution.uppercased())") : Text("Wrong answer: \(quiz.currentSolution.uppercased())"),
                          dismissButton: .default(Text("Continue"), action: {
                            if quiz.state == .play {
                                quiz.nextQuestion()
                                drawings = [Drawing]()
                            } else {
                                showScore.toggle()
                                self.presentation.wrappedValue.dismiss()
                            }
                        })
                    )
                })
            } else {
                VStack {
                    QuizHeader(quiz: quiz, showScore: $showScore, heightDevice: heightDevice)
                        .padding(.top, 5)
                    BodyQuizWriting(
                        quiz: quiz,
                        drawing: $drawing,
                        drawings: $drawings,
                        image: $image,
                        widthDevice: widthDevice,
                        heightDevice: heightDevice,
                        showActionSheet: $showActionSheet)
                }.background(Color(UIColor.secondarySystemBackground))
                .actionSheet(isPresented: $showActionSheet, content: {
                    ActionSheet(
                        title: quiz.correctAnswer ? Text("Right answer: \(quiz.currentSolution.uppercased())") : Text("Wrong answer: \(quiz.currentSolution.uppercased())"),
                        buttons: [
                            .default(Text("Continue"), action: {
                                if quiz.state == .play {
                                    quiz.nextQuestion()
                                    drawings = [Drawing]()
                                } else {
                                    showScore.toggle()
                                    self.presentation.wrappedValue.dismiss()
                                }
                            })
                        ]
                    )
                })
            }
        })
    }
}

struct QuizWriting_Previews: PreviewProvider {
    static var previews: some View {
        QuizWriting(
            quiz: Quiz(
                quickQuiz: true,
                difficulty: .hard,
                direction: .toKana,
                hiragana: false,
                katakana: true,
                kanaSection: .all,
                nbQuestions: 5.0),
            showScore: .constant(false)
        )
    }
}
