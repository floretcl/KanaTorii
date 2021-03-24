//
//  QuizMCQ.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizMCQ: View {
    @Environment(\.presentationMode) var presentation
    
    @StateObject var quiz: Quiz
    var label: String {
        if quiz.translationDirection == .toRomaji {
            return quiz.currentKana
        } else {
            return quiz.currentName
        }
    }
    
    let itemsCellIphone = GridItem(.fixed(90))
    let itemsCellIpad = GridItem(.fixed(160))
    
    @State var showActionSheet: Bool = false
    @Binding var showScore: Bool
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let heightDevice = geometry.size.height
                VStack {
                    QuizHeader(quiz: quiz, showScore: $showScore, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleQuizMCQ(heightDevice: heightDevice)
                            Text(label)
                                .font(.system(size: heightDevice/10))
                                .padding(heightDevice/35)
                            Spacer()
                            SuggestionsQuiz(quiz: quiz, items: itemsCellIpad, spacing: 30, width: 125, height: 125, textSize: heightDevice/24, showActionSheet: $showActionSheet)
                                .padding(.bottom, heightDevice/8)
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
                            self.presentation.wrappedValue.dismiss()
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
                            Text(label)
                                .font(.system(size: heightDevice/9))
                            Spacer()
                            SuggestionsQuiz(quiz: quiz, items: itemsCellIphone, spacing: 20, width: 80, height: 80, textSize: widthDevice/15, showActionSheet: $showActionSheet)
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
                                self.presentation.wrappedValue.dismiss()
                            }
                        })
                    ]
                )
            })
        }
    }
}

struct QuizMCQ_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuizMCQ(
                quiz: Quiz(
                    quickQuiz: false,
                    difficulty: .easy,
                    direction: .toRomaji,
                    hiragana: true,
                    katakana: false,
                    kanaSection: .all,
                    nbQuestions: 10.0),
                showScore: .constant(false)
            )
        }
    }
}
