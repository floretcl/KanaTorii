//
//  QuizMCQRomajiToKana.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizMCQRomajiToKana: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var quiz: Quiz
    @State var showActionSheet: Bool = false
    @Binding var showScore: Bool
    let itemsCellIphone = GridItem(.fixed(90))
    let itemsCellIpad = GridItem(.fixed(200))
    
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
                            TitleQuizMCQ(heightDevice: heightDevice)
                            Text(quiz.currentName)
                                .font(.system(size: heightDevice/9))
                                .padding(heightDevice/20)
                            Spacer()
                            SuggestionsQuiz(quiz: quiz, showActionSheet: $showActionSheet, items: itemsCellIpad, spacing: 40, width: 150, height: 150, textSize: widthDevice/20)
                                .padding(.bottom, heightDevice/10)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                //.navigationBarTitle()
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "),
                      message: quiz.correctAnswer ? Text("Right answer: \(quiz.currentSolution.uppercased())") : Text("Wrong answer: \(quiz.currentSolution.uppercased())"),
                      dismissButton: .default(Text("Continue"), action: {
                        if quiz.state == .play {
                            quiz.nextQuestion()
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
                            TitleQuizMCQ(heightDevice: heightDevice)
                            Text(quiz.currentName)
                                .font(.system(size: heightDevice/9))
                            Spacer()
                            SuggestionsQuiz(quiz: quiz, showActionSheet: $showActionSheet, items: itemsCellIphone, spacing: 20, width: 80, height: 80, textSize: widthDevice/15)
                                .padding(.bottom, heightDevice/10)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                //.navigationBarTitle()
            })
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(
                    title: quiz.correctAnswer ? Text("Right answer: \(quiz.currentSolution.uppercased())") : Text("Wrong answer: \(quiz.currentSolution.uppercased())"),
                    buttons: [
                        .default(Text("Continue"), action: {
                            if quiz.state == .play {
                                quiz.nextQuestion()
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

struct QuizMCQRomajiToKana_Previews: PreviewProvider {
    static var previews: some View {
        QuizMCQRomajiToKana(
            quiz: Quiz(
                quickQuiz: false,
                difficulty: .easy,
                direction: .toKana,
                hiragana: false,
                katakana: true,
                kanaSection: .gojuon,
                nbQuestions: 10.0),
            showScore: .constant(false)
        )
    }
}
