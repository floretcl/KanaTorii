//
//  BodyQuizKeyboard.swift
//  KanaTorii
//
//  Created by Clément FLORET on 23/03/2021.
//

import SwiftUI

struct BodyQuizKeyboard: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>

    @Environment(\.presentationMode) var presentation

    @StateObject var quiz: Quiz
    @Binding var text: String

    @Binding var showActionSheet: Bool
    @Binding var showScore: Bool

    @Binding var widthDeviceSaved: CGFloat
    @Binding var heightDeviceSaved: CGFloat

    var body: some View {
        VStack {
            QuizHeader(quiz: quiz, showScore: $showScore, heightDevice: heightDeviceSaved)
                .padding(.top, 5)
            HStack {
                Spacer()
                VStack {
                    TitleQuizKeyboard(quiz: quiz, heightDevice: heightDeviceSaved)
                    if UIDevice.current.localizedModel == "iPad" {
                        Text(quiz.currentKana)
                            .font(.system(size: heightDeviceSaved/5))
                            .padding(heightDeviceSaved/20)
                    } else {
                        Text(quiz.currentKana)
                            .font(.system(size: heightDeviceSaved/5))
                    }
                    HStack {
                        TextField("Enter your answer", text: $text) { _ in
                        } onCommit: {
                            quiz.answerCurrentQuestion(with: text)
                            addItemToCoreData(correctAnswer: quiz.correctAnswer)
                            showActionSheet.toggle()
                        }
                        .padding(.vertical, heightDeviceSaved/25)
                        .padding(.horizontal, widthDeviceSaved/4)
                        .disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.alphabet)
                    }.alert(isPresented: $showActionSheet, content: {
                        Alert(title: Text("Your result: "),
                              message: quiz.correctAnswer ? Text("Right answer: \(quiz.currentSolution.uppercased())") : Text("Wrong answer: \(quiz.currentSolution.uppercased())"),
                              dismissButton: .default(Text("Continue"), action: {
                                if quiz.state == .play {
                                    quiz.nextQuestion()
                                    text = ""
                                } else {
                                    showScore.toggle()
                                    self.presentation.wrappedValue.dismiss()
                                }
                            })
                        )
                    })
                    Spacer()
                }
                Spacer()
            }
        }
    }

    private func addItemToCoreData(correctAnswer: Bool) {
        var same: Bool = false
        for stat in statKana {
            if quiz.currentKana == stat.kana {
                if correctAnswer {
                    stat.nbCorrectAnswers += Float(1)
                }
                stat.nbTotalAnswers += Float(1)
                do {
                    try viewContext.save()
                } catch {
                    print(error)
                    // let nsError = error as NSError
                    // fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                same = true
            }
        }
        if same == false {
            let newStat = StatKana(context: viewContext)
            newStat.kana = quiz.currentKana
            newStat.romaji = quiz.currentRomaji
            if correctAnswer {
                newStat.nbCorrectAnswers = Float(1)
            }
            newStat.nbTotalAnswers = Float(1)
            do {
                try viewContext.save()
            } catch {
                print(error)
                // let nsError = error as NSError
                // fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct BodyQuizKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        BodyQuizKeyboard(
            quiz: Quiz(
                quickQuiz: true,
                difficulty: .hard,
                direction: .toRomaji,
                hiragana: true,
                katakana: false,
                kanaSection: .all,
                nbQuestions: 10.0),
            text: .constant(""),
            showActionSheet: .constant(false),
            showScore: .constant(false),
            widthDeviceSaved: .constant(300),
            heightDeviceSaved: .constant(800))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
