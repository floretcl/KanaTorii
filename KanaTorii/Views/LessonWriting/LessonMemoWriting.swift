//
//  LessonMemoWriting.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct LessonMemoWriting: View {
    @ObservedObject var currentLesson: Lesson
    @State var showTest: Bool = false
    @State var showQuiz: Bool = false
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
                                ContinueButtonTestLessonMemo(currentLesson: currentLesson, showTest: $showTest, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                .padding(.bottom, heightDevice/20)
                                .fullScreenCover(isPresented: $showTest, content: {
                                    TestWriting(
                                        currentLesson: currentLesson,
                                        test: TestDrawing(
                                            type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                            kana: currentLesson.currentKana,
                                            romaji: currentLesson.currentRomaji))
                                })
                                if currentLesson.currentPartNumber == currentLesson.totalParts - 1 {
                                    ContinueButtonQuizLessonMemo(currentLesson: currentLesson, showQuiz: $showQuiz, widthDevice: widthDevice, heightDevice: heightDevice)
                                    .padding(.bottom, heightDevice/20)
                                    .fullScreenCover(isPresented: $showQuiz, content: {
                                        //
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
                                ContinueButtonTestLessonMemo(currentLesson: currentLesson, showTest: $showTest, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
                                .padding(.bottom, heightDevice/20)
                                .sheet(isPresented: $showTest, content: {
                                    TestWriting(
                                        currentLesson: currentLesson,
                                        test: TestDrawing(
                                            type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                            kana: currentLesson.currentKana,
                                            romaji: currentLesson.currentRomaji))
                                })
                                if currentLesson.currentPartNumber == currentLesson.totalParts - 1 {
                                    ContinueButtonQuizLessonMemo(currentLesson: currentLesson, showQuiz: $showQuiz, widthDevice: widthDevice, heightDevice: heightDevice)
                                    .padding(.bottom, heightDevice/20)
                                    .sheet(isPresented: $showQuiz, content: {
                                        //
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