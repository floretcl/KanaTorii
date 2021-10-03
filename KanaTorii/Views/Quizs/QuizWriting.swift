//
//  QuizWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizWriting: View {
    @Environment(\.presentationMode) var presentation
    var secondaryBackgroundColor: Color = Color(UIColor.secondarySystemBackground)
    
    @StateObject var quiz: Quiz

    @State var drawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var image: UIImage = UIImage()

    @Binding var showScore: Bool
    @State var showActionSheet: Bool = false
    
    var widthDevice: CGFloat
    var heightDevice: CGFloat

    var body: some View {
        VStack {
            if UIDevice.current.localizedModel == "iPad" {
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
        }
        .background(secondaryBackgroundColor)
        .edgesIgnoringSafeArea(.bottom)
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
            showScore: .constant(false),
            widthDevice: 830,
            heightDevice: 380
        )
    }
}
