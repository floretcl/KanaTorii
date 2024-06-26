//
//  LessonMemoWriting.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct LessonMemoWriting: View {
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
            VStack {
                LessonHeader(
                    currentLesson: currentLesson,
                    lessonInfoMustClose: $lessonInfoMustClose,
                    heightDevice: heightDevice)
                    .padding(.top, 5)
                HStack {
                    Spacer()
                    VStack {
                        TitleLessonWriting(heightDevice: heightDevice)
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
                                .padding(.vertical, heightDevice/30)
                        }
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
                                        TestWriting(
                                            currentLesson: currentLesson,
                                            test: TestDrawing(
                                                type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                                kana: currentLesson.currentKana,
                                                romaji: currentLesson.currentRomaji),
                                            showQuiz: $showQuiz,
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
                                    MiniQuizWriting(
                                        currentLesson: currentLesson,
                                        miniQuiz: MiniQuiz(
                                            type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                            kanas: currentLesson.kanas,
                                            romajis: currentLesson.romajis, draw: true),
                                        lessonInfoMustClose: $lessonInfoMustClose)
                                        .environment(\.managedObjectContext, self.viewContext)
                                })
                            }
                        }
                    }
                    Spacer()
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
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
                    kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"]),
                lessonInfoMustClose: .constant(false)
            )
        }
    }
}
