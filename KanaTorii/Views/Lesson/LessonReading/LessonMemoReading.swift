//
//  LessonMemoReading.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct LessonMemoReading: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatLesson.name, ascending: true)],
        animation: .default) var statLesson: FetchedResults<StatLesson>

    @Environment(\.presentationMode) private var presentation

    @StateObject var currentLesson: Lesson
    @State var showTest: Bool = false
    @State var showQuiz: Bool = false
    
    @Binding var lessonInfoMustClose: Bool

    var body: some View {
        GeometryReader(content: { geometry in
            let heightDevice = geometry.size.height
            let widthDevice = geometry.size.width
            ZStack {
                VStack {
                    LessonHeader(
                        currentLesson: currentLesson,
                        lessonInfoMustClose: $lessonInfoMustClose,
                        heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleLessonReading(heightDevice: heightDevice)
                            if UIDevice.current.localizedModel == "iPad" {
                                MemoCard(
                                    currentLesson: currentLesson,
                                    widthDevice: widthDevice,
                                    heightDevice: heightDevice)
                                    .padding(.vertical, heightDevice/18)
                            } else {
                                MemoCard(
                                    currentLesson: currentLesson,
                                    widthDevice: widthDevice,
                                    heightDevice: heightDevice)
                                    .padding(.vertical, heightDevice/50)
                            }
                            SoundButton(currentLesson: currentLesson)
                                .padding(5)
                            Spacer()
                            ZStack {
                                if currentLesson.currentPart != .quiz && currentLesson.currentPart != .score {
                                    ContinueButtonTest(
                                        currentLesson: currentLesson,
                                        widthDevice: widthDevice,
                                        heightDevice: heightDevice,
                                        textSize: heightDevice/40,
                                        showTest: $showTest)
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
                                                lessonInfoMustClose: $lessonInfoMustClose)
                                        })
                                } else if currentLesson.currentPart == .quiz {
                                    ContinueButtonQuiz(
                                        currentLesson: currentLesson,
                                        widthDevice: widthDevice,
                                        heightDevice: heightDevice,
                                        textSize: heightDevice/40,
                                        showQuiz: $showQuiz)
                                    .padding(.bottom, heightDevice/20)
                                    .fullScreenCover(
                                        isPresented: $showQuiz,
                                        onDismiss: {
                                            currentLesson.newPart()
                                            if currentLesson.state == .end {
                                                addItemToCoreData()
                                                currentLesson.reset()
                                                lessonInfoMustClose = true
                                                self.presentation.wrappedValue.dismiss()
                                            }
                                        },
                                        content: {
                                            MiniQuizReading(
                                            currentLesson: currentLesson,
                                            miniQuiz: MiniQuiz(
                                                type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                                kanas: currentLesson.kanas,
                                                romajis: currentLesson.romajis, draw: false),
                                            lessonInfoMustClose: $lessonInfoMustClose)
                                            .environment(\.managedObjectContext, self.viewContext)
                                    })
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }).background(Color(UIColor.secondarySystemBackground))
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
                // let nsError = error as NSError
                // fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
                    kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"]),
                lessonInfoMustClose: .constant(false)
            )
        }
    }
}
