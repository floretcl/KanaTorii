//
//  QuizForTestReading.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct QuizForTestReading: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var currentLesson: Lesson
    @ObservedObject var quizForTest: QuizForTest
    @State var showActionSheet: Bool = false
    @State var showMessage: Bool = false
    private var label: String {
        if quizForTest.translationDirection == .toKana {
            return quizForTest.currentRomaji
        } else {
            return quizForTest.currentKana
        }
    }
    let itemsCellIphone = GridItem(.fixed(120))
    let itemsCellIpad = GridItem(.fixed(200))
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let heightDevice = geometry.size.height
                VStack {
                    LessonHeader(currentLesson: currentLesson, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleTestReading(heightDevice: heightDevice)
                            Text(label)
                                .font(.system(size: heightDevice/7))
                                .padding(heightDevice/35)
                            Spacer()
                            SuggestionsTestQuiz(quizForTest: quizForTest, showActionSheet: $showActionSheet, items: itemsCellIpad, spacing: 35, width: 175, height: 175, textSize: heightDevice/24)
                                .padding(.bottom, heightDevice/8)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                .navigationBarTitle(currentLesson.name)
                .edgesIgnoringSafeArea(.bottom)
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "),
                      message: quizForTest.correctAnswer ? Text("Right answer: \(quizForTest.currentSolution.uppercased())") : Text("Wrong answer: \(quizForTest.currentSolution.uppercased())"),
                      dismissButton: .default(Text("Continue"), action: {
                        if quizForTest.state == .play {
                            quizForTest.nextQuestion()
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
                    LessonHeader(currentLesson: currentLesson, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleTestReading(heightDevice: heightDevice)
                            Text(label)
                                .font(.system(size: heightDevice/5))
                            Spacer()
                            SuggestionsTestQuiz(quizForTest: quizForTest, showActionSheet: $showActionSheet, items: itemsCellIphone, spacing: 30, width: 100, height: 100, textSize: widthDevice/14)
                                .padding(.bottom, heightDevice/10)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                .navigationBarTitle(currentLesson.name)
                .edgesIgnoringSafeArea(.bottom)
            })
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(
                    title: quizForTest.correctAnswer ? Text("Right answer: \(quizForTest.currentSolution.uppercased())") : Text("Wrong answer: \(quizForTest.currentSolution.uppercased())"),
                    buttons: [
                        .default(Text("Continue"), action: {
                            if quizForTest.state == .play {
                                quizForTest.nextQuestion()
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

struct QuizForTestReading_Previews: PreviewProvider {
    static var previews: some View {
        QuizForTestReading(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana", kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]),
            quizForTest: QuizForTest(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                draw: false)
        )
    }
}
