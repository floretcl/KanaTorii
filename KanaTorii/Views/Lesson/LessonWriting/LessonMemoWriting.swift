//
//  LessonMemoWriting.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct LessonMemoWriting: View {
    @Environment(\.presentationMode) private var presentation
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatLesson.name, ascending: true)],
        animation: .default) var statLesson: FetchedResults<StatLesson>
    @ObservedObject var currentLesson: Lesson
    @State var showTest: Bool = false
    @State var showQuiz: Bool = false
    @State var showScore: Bool = false
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let heightDevice = geometry.size.height
                let widthDevice = geometry.size.width
                VStack {
                    LessonHeader(currentLesson: currentLesson, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleLesson(heightDevice: heightDevice, text: "Memorize the writing order of the lines and the shape of this kana")
                            MemoCard(
                                currentLesson: currentLesson,
                                widthDevice: widthDevice,
                                heightDevice: heightDevice)
                                .padding(.vertical, heightDevice/12)
                                .padding(.horizontal, widthDevice/4)
                            Spacer()
                            ZStack {
                                ContinueButtonTest(currentLesson: currentLesson, showTest: $showTest, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                .padding(.bottom, heightDevice/20)
                                .fullScreenCover(
                                    isPresented: $showTest,
                                    onDismiss: {
                                        showQuiz.toggle()
                                    },
                                    content: {
                                    TestWriting(
                                        currentLesson: currentLesson,
                                        test: TestDrawing(
                                            type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                            kana: currentLesson.currentKana,
                                            romaji: currentLesson.currentRomaji))
                                })
                                if currentLesson.currentPart == .quiz {
                                    ContinueButtonQuiz(currentLesson: currentLesson, showQuiz: $showQuiz, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                    .padding(.bottom, heightDevice/20)
                                    .fullScreenCover(
                                        isPresented: $showQuiz,
                                        onDismiss: {
                                            currentLesson.newPart()
                                            showScore.toggle()
                                        },
                                        content: {
                                        QuizForTestWriting(
                                            currentLesson: currentLesson,
                                            quizForTest: QuizForTest(
                                                type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                                kanas: currentLesson.kanas,
                                                romajis: currentLesson.romajis, draw: true))
                                    })
                                } else if currentLesson.currentPart == .score {
                                    ContinueButtonScore(currentLesson: currentLesson, showScore: $showScore, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                    .padding(.bottom, heightDevice/20)
                                    .sheet(
                                        isPresented: $showScore,
                                        onDismiss: {
                                            addItemToCoreData()
                                            self.presentation.wrappedValue.dismiss()
                                        },
                                        content: {
                                            ScoreView()
                                    })
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle(currentLesson.name)
            }).background(Color(UIColor.secondarySystemBackground))
        } else {
            GeometryReader(content: { geometry in
                let heightDevice = geometry.size.height
                let widthDevice = geometry.size.width
                VStack {
                    LessonHeader(currentLesson: currentLesson, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleLesson(heightDevice: heightDevice, text: "Memorize the writing order of the lines and the shape of this kana")
                            MemoCard(
                                currentLesson: currentLesson,
                                widthDevice: widthDevice,
                                heightDevice: heightDevice)
                                .padding(.vertical, heightDevice/50)
                                .padding(.horizontal, widthDevice/4.5)
                            Spacer()
                            ZStack {
                                ContinueButtonTest(currentLesson: currentLesson, showTest: $showTest, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                .padding(.bottom, heightDevice/20)
                                .fullScreenCover(
                                    isPresented: $showTest,
                                    onDismiss: {
                                        showQuiz.toggle()
                                    },
                                    content: {
                                    TestWriting(
                                        currentLesson: currentLesson,
                                        test: TestDrawing(
                                            type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                            kana: currentLesson.currentKana,
                                            romaji: currentLesson.currentRomaji))
                                })
                                if currentLesson.currentPart == .quiz {
                                    ContinueButtonQuiz(currentLesson: currentLesson, showQuiz: $showQuiz, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                    .padding(.bottom, heightDevice/20)
                                    .fullScreenCover(
                                        isPresented: $showQuiz,
                                        onDismiss: {
                                            currentLesson.newPart()
                                            showScore.toggle()
                                        },
                                        content: {
                                        QuizForTestWriting(
                                            currentLesson: currentLesson,
                                            quizForTest: QuizForTest(
                                                type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                                kanas: currentLesson.kanas,
                                                romajis: currentLesson.romajis, draw: true))
                                    })
                                } else if currentLesson.currentPart == .score {
                                    ContinueButtonScore(currentLesson: currentLesson, showScore: $showScore, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                    .padding(.bottom, heightDevice/20)
                                    .sheet(
                                        isPresented: $showScore,
                                        onDismiss: {
                                            addItemToCoreData()
                                            self.presentation.wrappedValue.dismiss()
                                        },
                                        content: {
                                            ScoreView()
                                    })
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle(currentLesson.name)
            }).background(Color(UIColor.secondarySystemBackground))
        }
    }
    private func addItemToCoreData() {
        var same: Bool = false
        for stat in statLesson {
            if currentLesson.name == stat.name {
                same = true
            }
        }
        if same == false {
            let newStat = StatLesson(context: viewContext)
            newStat.name = currentLesson.name
            newStat.done = true
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct LessonMemoWriting_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LessonMemoWriting(
                currentLesson: Lesson(
                    name: "Lesson 1 Hiragana a i u e o | Writing",
                    mode: .writing,
                    kanaType: "hiragana",
                    kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"])
            )
        }
    }
}
