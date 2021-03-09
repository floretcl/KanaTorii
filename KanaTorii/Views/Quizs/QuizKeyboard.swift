//
//  QuizKeyboard.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizKeyboard: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>
    @ObservedObject var quiz: Quiz
    @State var showActionSheet: Bool = false
    @State var text: String = ""
    @State var widthDeviceSaved: CGFloat = 0
    @State var heightDeviceSaved: CGFloat = 0
    @Binding var showScore: Bool
    private var textActionSheet: String {
        if quiz.correctAnswer {
            return "Right answer: \(quiz.currentSolution.uppercased())"
        } else {
            return "Wrong answer: \(quiz.currentSolution.uppercased())"
        }
    }
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    QuizHeader(quiz: quiz, showScore: $showScore, heightDevice: heightDeviceSaved)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleQuiz(heightDevice: heightDeviceSaved, text: "Write the Romaji for \(quiz.currentKana.capitalized)")
                            Text(quiz.currentKana)
                                .font(.system(size: heightDeviceSaved/5))
                                .padding(heightDeviceSaved/20)
                            HStack {
                                TextField("Enter your answer", text: $text) { Boolean in
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
                                Alert(title: Text("Your result: "), message: Text(textActionSheet), dismissButton: .default(Text("Continue"), action: {
                                        if quiz.state == .play {
                                            quiz.nextQuestion()
                                            text = ""
                                        } else {
                                            showScore.toggle()
                                            presentation.wrappedValue.dismiss()
                                        }
                                    })
                                )
                            })
                            Spacer()
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                //.navigationBarTitle()
                .onAppear(perform: {
                    widthDeviceSaved = widthDevice
                    heightDeviceSaved = heightDevice
                })
            })
        } else {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    QuizHeader(quiz: quiz, showScore: $showScore, heightDevice: heightDeviceSaved)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleQuiz(heightDevice: heightDeviceSaved, text: "Write the Romaji for:")
                            Text(quiz.currentKana)
                                .font(.system(size: heightDeviceSaved/5))
                            HStack {
                                TextField("Enter your answer", text: $text) { Boolean in
                                } onCommit: {
                                    quiz.answerCurrentQuestion(with: text)
                                    addItemToCoreData(correctAnswer: quiz.correctAnswer)
                                    showActionSheet.toggle()
                                }
                                .padding(.vertical, heightDeviceSaved/25)
                                .padding(.horizontal, widthDeviceSaved/6)
                                .disableAutocorrection(true)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            }.actionSheet(isPresented: $showActionSheet, content: {
                                ActionSheet(
                                    title: Text(textActionSheet),
                                    buttons: [
                                        .default(Text("Continue"), action: {
                                            if quiz.state == .play {
                                                quiz.nextQuestion()
                                                text = ""
                                            } else {
                                                showScore.toggle()
                                                presentation.wrappedValue.dismiss()
                                            }
                                        })
                                    ]
                                )
                            })
                            Spacer()
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                //.navigationBarTitle()
                .edgesIgnoringSafeArea(.bottom)
                .onAppear(perform: {
                    widthDeviceSaved = widthDevice
                    heightDeviceSaved = heightDevice
                })
            })
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
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct QuizKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuizKeyboard(
                quiz: Quiz(
                    quickQuiz: true,
                    difficulty: .hard,
                    direction: .toRomaji,
                    hiragana: true,
                    katakana: false,
                    kanaSection: .all,
                    nbQuestions: 10.0),
                showScore: .constant(false)
            ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
