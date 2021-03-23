//
//  MiniQuizReading.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct MiniQuizReading: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var currentLesson: Lesson
    @ObservedObject var miniQuiz: MiniQuiz
    
    @State var showActionSheet: Bool = false
    @State var showMessage: Bool = false
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            BodyMiniQuizReading(currentLesson: currentLesson, miniQuiz: miniQuiz, showActionSheet: $showActionSheet)
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "),
                      message: miniQuiz.correctAnswer ? Text("Right answer: \(miniQuiz.currentSolution.uppercased())") : Text("Wrong answer: \(miniQuiz.currentSolution.uppercased())"),
                      dismissButton: .default(Text("Continue"), action: {
                        if miniQuiz.state == .play {
                            miniQuiz.nextQuestion()
                        } else {
                            presentation.wrappedValue.dismiss()
                        }
                    })
                )
            })
        } else {
            BodyMiniQuizReading(currentLesson: currentLesson, miniQuiz: miniQuiz, showActionSheet: $showActionSheet)
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(
                    title: miniQuiz.correctAnswer ? Text("Right answer: \(miniQuiz.currentSolution.uppercased())") : Text("Wrong answer: \(miniQuiz.currentSolution.uppercased())"),
                    buttons: [
                        .default(Text("Continue"), action: {
                            if miniQuiz.state == .play {
                                miniQuiz.nextQuestion()
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

struct MiniQuizReading_Previews: PreviewProvider {
    static var previews: some View {
        MiniQuizReading(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana", kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]),
            miniQuiz: MiniQuiz(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                draw: false)
        )
    }
}
