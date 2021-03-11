//
//  LessonMemoReading.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct LessonMemoReading: View {
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
                            TitleLessonReading(heightDevice: heightDevice)
                            MemoCard(currentLesson: currentLesson, widthDevice: widthDevice, heightDevice: heightDevice)
                                .padding(.vertical, heightDevice/12)
                                .padding(.horizontal, widthDevice/4)
                            SoundButton(currentLesson: currentLesson)
                                .padding(heightDevice/80)
                            Spacer()
                            ZStack {
                                ContinueButtonTest(currentLesson: currentLesson, showTest: $showTest, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                .padding(.bottom, heightDevice/20)
                                .fullScreenCover(
                                    isPresented: $showTest,
                                    onDismiss: {
                                        if currentLesson.state == .end {
                                            currentLesson.reset()
                                            self.presentation.wrappedValue.dismiss()
                                        }
                                    },
                                    content: {
                                        TestReading(
                                            currentLesson: currentLesson,
                                            test: Test(
                                                type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                                kanas: currentLesson.kanas,
                                                romajis: currentLesson.romajis,
                                                currentIndex: currentLesson.kanaIndex),
                                            showQuiz: $showQuiz)
                                    })
                                if currentLesson.currentPart == .quiz {
                                    ContinueButtonQuiz(currentLesson: currentLesson, showQuiz: $showQuiz, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                    .padding(.bottom, heightDevice/20)
                                    .fullScreenCover(
                                        isPresented: $showQuiz,
                                        onDismiss: {
                                            currentLesson.newPart()
                                            showScore.toggle()
                                            if currentLesson.state == .end {
                                                currentLesson.reset()
                                                self.presentation.wrappedValue.dismiss()
                                            }
                                        },content: {
                                            QuizForTestReading(
                                                currentLesson: currentLesson,
                                                quizForTest: QuizForTest(
                                                    type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                                    kanas: currentLesson.kanas,
                                                    romajis: currentLesson.romajis, draw: false)
                                            )
                                        })
                                } else if currentLesson.currentPart == .score {
                                    ContinueButtonScore(currentLesson: currentLesson, showScore: $showScore, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                    .padding(.bottom, heightDevice/20)
                                    .sheet(
                                        isPresented: $showScore,
                                        onDismiss: {
                                            addItemToCoreData()
                                            currentLesson.reset()
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
                            TitleLessonReading(heightDevice: heightDevice)
                            MemoCard(currentLesson: currentLesson, widthDevice: widthDevice, heightDevice: heightDevice)
                                .padding(.vertical, heightDevice/50)
                                .padding(.horizontal, widthDevice/4.5)
                            SoundButton(currentLesson: currentLesson)
                                .padding(heightDevice/80)
                            Spacer()
                            ZStack {
                                ContinueButtonTest(currentLesson: currentLesson, showTest: $showTest, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                    .padding(.bottom, heightDevice/20)
                                    .fullScreenCover(
                                        isPresented: $showTest,
                                        onDismiss: {
                                            if currentLesson.state == .end {
                                                currentLesson.reset()
                                                self.presentation.wrappedValue.dismiss()
                                            }
                                        },
                                        content: {
                                        TestReading(
                                            currentLesson: currentLesson,
                                            test: Test(
                                                type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                                kanas: currentLesson.kanas,
                                                romajis: currentLesson.romajis,
                                                currentIndex: currentLesson.kanaIndex),
                                            showQuiz: $showQuiz
                                        )
                                    })
                                if currentLesson.currentPart == .quiz {
                                    ContinueButtonQuiz(currentLesson: currentLesson, showQuiz: $showQuiz, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                        .padding(.bottom, heightDevice/20)
                                        .fullScreenCover(isPresented: $showQuiz,
                                               onDismiss: {
                                                currentLesson.newPart()
                                                showScore.toggle()
                                                if currentLesson.state == .end {
                                                    currentLesson.reset()
                                                    self.presentation.wrappedValue.dismiss()
                                                }
                                               },content: {
                                                QuizForTestReading(
                                                    currentLesson: currentLesson,
                                                    quizForTest: QuizForTest(
                                                        type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                                        kanas: currentLesson.kanas,
                                                        romajis: currentLesson.romajis, draw: false)
                                                )
                                        })
                                } else if currentLesson.currentPart == .score {
                                    ContinueButtonScore(currentLesson: currentLesson, showScore: $showScore, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                    .padding(.bottom, heightDevice/20)
                                    .sheet(
                                        isPresented: $showScore,
                                        onDismiss: {
                                            addItemToCoreData()
                                            currentLesson.reset()
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
                print(error)
                //let nsError = error as NSError
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct LessonMemoReading_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LessonMemoReading(
                currentLesson: Lesson(
                    name: "Lesson 1 Hiragana a i u e o | Reading",
                    mode: .reading,
                    kanaType: "hiragana",
                    kanas: ["あ","い","う","え","お"],
                    romajis: ["a","i","u","e","o"])
            )
        }
    }
}
