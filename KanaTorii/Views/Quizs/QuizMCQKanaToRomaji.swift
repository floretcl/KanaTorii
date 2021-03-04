//
//  QuizMCQKanaToRomaji.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizMCQKanaToRomaji: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var quiz: Quiz
    @State var showActionSheet: Bool = false
    let itemsCellIphone = GridItem(.fixed(90))
    let itemsCellIpad = GridItem(.fixed(220))
    private var textActionSheet: String {
        if quiz.correctAnswer {
            return "Right Answer: \(quiz.currentSolution.uppercased())"
        } else {
            return "Wrong Answer: \(quiz.currentSolution.uppercased())"
        }
    }
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    QuizHeader(quiz: quiz, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleQuiz(heightDevice: heightDevice, text: "Find correct answer")
                            Text(quiz.currentKana)
                                .font(.system(size: heightDevice/5))
                                .padding(heightDevice/20)
                            Spacer()
                            SuggestionsQuiz(quiz: quiz, showActionSheet: $showActionSheet, items: itemsCellIpad, spacing: 40, width: 200, height: 200, textSize: widthDevice/20)
                                .padding(.bottom, heightDevice/10)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                //.navigationBarTitle()
                .edgesIgnoringSafeArea(.bottom)
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "), message: Text(textActionSheet), dismissButton: .default(Text("Continue"), action: {
                        if quiz.state == .play {
                            quiz.nextQuestion()
                        } else {
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
                    QuizHeader(quiz: quiz, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleQuiz(heightDevice: heightDevice, text: "Find correct answer")
                            Text(quiz.currentKana)
                                .font(.system(size: heightDevice/6))
                            Spacer()
                            SuggestionsQuiz(quiz: quiz, showActionSheet: $showActionSheet, items: itemsCellIphone, spacing: 20, width: 80, height: 80, textSize: widthDevice/15)
                                .padding(.bottom, heightDevice/10)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                //.navigationBarTitle()
                .edgesIgnoringSafeArea(.bottom)
            })
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(
                    title: Text(textActionSheet),
                    buttons: [
                        .default(Text("Continue"), action: {
                            if quiz.state == .play {
                                quiz.nextQuestion()
                            } else {
                                presentation.wrappedValue.dismiss()
                            }
                        })
                    ]
                )
            })
        }

    }
}

struct QuizMCQKanaToRomaji_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuizMCQKanaToRomaji(
                quiz: Quiz(
                    quickQuiz: false,
                    difficulty: .easy,
                    direction: .toRomaji,
                    hiragana: true,
                    katakana: false,
                    kanaSection: .all,
                    nbQuestions: 10.0)
            )
        }
    }
}
