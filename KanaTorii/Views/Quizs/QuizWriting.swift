//
//  QuizWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizWriting: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var quiz: Quiz
    @State var showActionSheet: Bool = false
    @State var drawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var image: UIImage = UIImage()
    @Binding var showScore: Bool
    private var textActionSheet: String {
        if quiz.correctAnswer {
            return "Right answer: \(quiz.currentSolution.uppercased())"
        } else {
            return "Wrong answer: \(quiz.currentSolution.uppercased())"
        }
    }
    private var kanaType: String {
        if quiz.hiragana {
            return "hiragana"
        } else {
            return "katakana"
        }
    }
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    QuizHeader(quiz: quiz, showScore: $showScore, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleQuiz(heightDevice: heightDevice, text: "Draw \(kanaType) for \(quiz.currentName.capitalized)")
                            Spacer()
                            DrawingPadQuiz(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/60)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonQuiz(drawings: $drawings, sizeText: heightDevice/40, width: widthDevice/6, height: heightDevice/22)
                            Spacer()
                            ContinueButtonQuizDrawing(quiz: quiz, showActionSheet: $showActionSheet, drawings: $drawings, image: $image, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                .padding(.bottom, heightDevice/20)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                //.navigationBarTitle()
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "), message: Text(textActionSheet), dismissButton: .default(Text("Continue"), action: {
                        if quiz.state == .play {
                            quiz.nextQuestion()
                            drawings = [Drawing]()
                        } else {
                            showScore.toggle()
                            presentation.wrappedValue.dismiss()
                        }
                    })
                )
            })
        } else {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    QuizHeader(quiz: quiz, showScore: $showScore, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleQuiz(heightDevice: heightDevice, text: "Draw \(kanaType) for \(quiz.currentName.capitalized)")
                            DrawingPadQuiz(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/35)
                                .frame(minWidth: 220, idealWidth: 300, maxWidth: 600, minHeight: 220, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonQuiz(drawings: $drawings, sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                            Spacer()
                            ContinueButtonQuizDrawing(quiz: quiz, showActionSheet: $showActionSheet, drawings: $drawings, image: $image, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                .padding(.bottom, heightDevice/20)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                //.navigationBarTitle()
            })
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(
                    title: Text(textActionSheet),
                    buttons: [
                        .default(Text("Continue"), action: {
                            if quiz.state == .play {
                                quiz.nextQuestion()
                                drawings = [Drawing]()
                            } else {
                                showScore.toggle()
                                presentation.wrappedValue.dismiss()
                            }
                        })
                    ]
                )
            })
        }
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
