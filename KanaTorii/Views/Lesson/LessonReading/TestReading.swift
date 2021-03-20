//
//  TestReading.swift
//  Kana Torii
//
//  Created by Clément FLORET on 02/02/2021.
//

import SwiftUI

struct TestReading: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @ObservedObject var currentLesson: Lesson
    @ObservedObject var test: Test
    @Binding var showQuiz: Bool
    @State var numberOfDisplayActionSheet: Int = 0
    @State var showActionSheet: Bool = false
    private var label: String {
        if test.translationDirection == .toKana {
            return test.currentRomaji
        } else {
            return test.currentKana
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
                            SuggestionsTest(test: test, showActionSheet: $showActionSheet, items: itemsCellIpad, spacing: 35, width: 175, height: 175, textSize: heightDevice/24)
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
                      message: test.correctAnswer ? Text("Right answer: \(test.currentSolution.uppercased())") : Text("Wrong answer: \(test.currentSolution.uppercased())"),
                      dismissButton: .default(Text("Continue"), action: {
                    numberOfDisplayActionSheet += 1
                    if numberOfDisplayActionSheet == 2 {
                        currentLesson.newPart()
                        if currentLesson.currentPart == .quiz {
                            showQuiz.toggle()
                        }
                        presentation.wrappedValue.dismiss()
                    }
                    test.nextQuestion()
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
                            SuggestionsTest(test: test, showActionSheet: $showActionSheet, items: itemsCellIphone, spacing: 30, width: 100, height: 100, textSize: widthDevice/14)
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
                    title: test.correctAnswer ? Text("Right answer: \(test.currentSolution.uppercased())") : Text("Wrong answer: \(test.currentSolution.uppercased())"),
                    buttons: [
                        .default(Text("Continue"), action: {
                            numberOfDisplayActionSheet += 1
                            if numberOfDisplayActionSheet == 2 {
                                currentLesson.newPart()
                                if currentLesson.currentPart == .quiz {
                                    showQuiz.toggle()
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
                    currentIndex: 0),
                showQuiz: .constant(false)
            )
        }
    }
}
