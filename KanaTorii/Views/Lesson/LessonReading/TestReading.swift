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
    
    @Binding var showQuiz: Bool
    
    @State var showActionSheet: Bool = false
    @State var numberOfDisplayActionSheet: Int = 0
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            BodyTestReading(currentLesson: currentLesson, test: test, showActionSheet: $showActionSheet)
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
                        self.presentation.wrappedValue.dismiss()
                    }
                    test.nextQuestion()
                    })
                )
            })
        } else {
            BodyTestReading(currentLesson: currentLesson, test: test, showActionSheet: $showActionSheet)
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
