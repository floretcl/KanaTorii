//
//  TestReading.swift
//  Kana Torii
//
//  Created by Clément FLORET on 02/02/2021.
//

import SwiftUI

struct TestReading: View {
    @Environment(\.presentationMode) var presentation

    @StateObject var currentLesson: Lesson
    @StateObject var test: Test

    @State var showActionSheet: Bool = false
    @State var numberOfDisplayActionSheet: Int = 0
    
    @Binding var lessonInfoMustClose: Bool

    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            BodyTestReading(
                currentLesson: currentLesson,
                test: test,
                showActionSheet: $showActionSheet,
                lessonInfoMustClose: $lessonInfoMustClose)
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "),
                      message: test.correctAnswer ? Text("Right answer: \(test.currentSolution.uppercased())") : Text("Wrong answer: \(test.currentSolution.uppercased())"),
                      dismissButton: .default(Text("Continue"), action: {
                    numberOfDisplayActionSheet += 1
                    if numberOfDisplayActionSheet == 2 {
                        currentLesson.newPart()
                        self.presentation.wrappedValue.dismiss()
                    }
                    test.nextQuestion()
                    })
                )
            })
        } else {
            BodyTestReading(
                currentLesson: currentLesson,
                test: test,
                showActionSheet: $showActionSheet,
                lessonInfoMustClose: $lessonInfoMustClose)
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(
                    title: test.correctAnswer ? Text("Right answer: \(test.currentSolution.uppercased())") : Text("Wrong answer: \(test.currentSolution.uppercased())"),
                    buttons: [
                        .default(Text("Continue"), action: {
                            numberOfDisplayActionSheet += 1
                            if numberOfDisplayActionSheet == 2 {
                                currentLesson.newPart()
                                self.presentation.wrappedValue.dismiss()
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
                    kanaType: "hiragana", kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"]),
                test: Test(
                    type: .hiragana,
                    kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"],
                    currentIndex: 0),
                lessonInfoMustClose: .constant(false)
            )
        }
    }
}
