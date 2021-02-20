//
//  TestReading.swift
//  Kana Torii
//
//  Created by Clément FLORET on 02/02/2021.
//

import SwiftUI

struct TestReading: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var currentLesson: Lesson
    @ObservedObject var test: Test
    @State var numberOfDisplayActionSheet: Int = 0
    @State var showActionSheet: Bool = false
    private var label: String {
        if test.translationDirection == .toKana {
            return test.currentRomaji
        } else {
            return test.currentKana
        }
    }
    private var textActionSheet: String {
        if test.correctAnswer {
            return "Right Answer"
        } else {
            return "Wrong Answer"
        }
    }
    let itemsCellIphone = GridItem(.fixed(120))
    let itemsCellIpad = GridItem(.fixed(220))
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
                            TitleLesson(heightDevice: heightDevice, text: "Find correct answer")
                            Text(label)
                                .font(.system(size: heightDevice/5))
                                .padding(heightDevice/20)
                            Spacer()
                            SuggestionsTest(test: test, showActionSheet: $showActionSheet, items: itemsCellIpad, spacing: 40, width: 200, height: 200, textSize: heightDevice/30)
                                .padding(.bottom, heightDevice/10)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                .navigationBarTitle(currentLesson.name)
                .edgesIgnoringSafeArea(.bottom)
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "), message: Text(textActionSheet), dismissButton: .default(Text("Continue"), action: {
                    numberOfDisplayActionSheet += 1
                    if numberOfDisplayActionSheet == 2 {
                        if currentLesson.nextPart == .memo {
                            currentLesson.newPart()
                        }
                        presentation.wrappedValue.dismiss()
                    }
                    test.nextQuestion()
                    })
                )
            })
        } else {
            GeometryReader(content: { geometry in
                let heightDevice = geometry.size.height
                VStack {
                    LessonHeader(currentLesson: currentLesson, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleLesson(heightDevice: heightDevice, text: "Find correct answer")
                            Text(label)
                                .font(.system(size: heightDevice/5))
                            Spacer()
                            SuggestionsTest(test: test, showActionSheet: $showActionSheet, items: itemsCellIphone, spacing: 30, width: 100, height: 100, textSize: heightDevice/25)
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
                    title: Text(textActionSheet),
                    buttons: [
                        .default(Text("Continue"), action: {
                            numberOfDisplayActionSheet += 1
                            if numberOfDisplayActionSheet == 2 {
                                if currentLesson.nextPart == .memo {
                                    currentLesson.newPart()
                                }
                                presentation.wrappedValue.dismiss()
                            }
                            test.nextQuestion()
                        })
                    ]
                )
            })
        }
    }
}

struct TestReading_Previews: PreviewProvider {
    static var lessons = ModelData().lessons
    static var previews: some View {
        Group {
            TestReading(
                currentLesson: Lesson(
                    name: "Lesson 1 Hiragana a i u e o | Reading",
                    mode: .reading,
                    kanaType: "hiragana", kanas: ["あ","い","う","え","お"],
                    romajis: ["a","i","u","e","o"]),
                test: Test(
                    type: .hiragana,
                    kanas: ["あ","い","う","え","お"],
                    romajis: ["a","i","u","e","o"],
                    currentIndex: 0)
            )
        }
    }
}
