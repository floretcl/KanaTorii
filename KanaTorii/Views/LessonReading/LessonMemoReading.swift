//
//  LessonMemoReading.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct LessonMemoReading: View {
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
                            Text("Memorize the shape and pronunciation of this kana")
                                .font(.system(size: heightDevice/35))
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                                .padding(.vertical, heightDevice/70)
                                .padding(.horizontal, 20)
                            MemoCard(currentLesson: currentLesson, widthDevice: widthDevice, heightDevice: heightDevice)
                                .padding(.vertical, heightDevice/12)
                                .padding(.horizontal, widthDevice/4)
                            Button(action: {
                                currentLesson.readTextInJapanese(text: currentLesson.currentKana)
                            }, label: {
                                SoundImage(sizeText: 40)
                            })
                            .padding(heightDevice/80)
                            Spacer()
                            ZStack {
                                Button(action: {
                                    showTest.toggle()
                                    currentLesson.newPart()
                                }, label: {
                                    ContinueLabel(
                                        widthDevice: widthDevice,
                                        heightDevice: heightDevice)
                                })
                                .padding(.bottom, heightDevice/20)
                                .fullScreenCover(isPresented: $showTest, content: {
                                    TestReading(
                                        currentLesson: currentLesson,
                                        test: Test(
                                            type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                            kanas: currentLesson.kanas,
                                            romajis: currentLesson.romajis,
                                            currentIndex: currentLesson.kanaIndex))
                                })
                                if currentLesson.currentPartNumber == currentLesson.totalParts - 1 {
                                    Button(action: {
                                        showQuiz.toggle()
                                    }, label: {
                                        ContinueLabel(
                                            widthDevice: widthDevice,
                                            heightDevice: heightDevice)
                                    })
                                    .padding(.bottom, heightDevice/20)
                                    .fullScreenCover(isPresented: $showQuiz, content: {
                                        Quiz()
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
                            Text("Memorize the shape and pronunciation of this kana")
                                .font(.system(size: heightDevice/35))
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                                .padding(.vertical, heightDevice/70)
                            .padding(.horizontal, 20)
                            MemoCard(currentLesson: currentLesson, widthDevice: widthDevice, heightDevice: heightDevice)
                            .padding(.vertical, heightDevice/50)
                            .padding(.horizontal, widthDevice/4.5)
                            Button(action: {
                                currentLesson.readTextInJapanese(text: currentLesson.currentKana)
                            }, label: {
                                SoundImage(sizeText: 30)
                            })
                            .padding(heightDevice/80)
                            Spacer()
                            ZStack {
                                Button(action: {
                                    showTest.toggle()
                                    currentLesson.newPart()
                                }, label: {
                                    ContinueLabel(
                                        widthDevice: widthDevice,
                                        heightDevice: heightDevice)
                                })
                                .padding(.bottom, heightDevice/20)
                                .sheet(isPresented: $showTest, content: {
                                    TestReading(
                                        currentLesson: currentLesson,
                                        test: Test(
                                            type: currentLesson.kanaType == "hiragana" ? .hiragana : .katakana,
                                            kanas: currentLesson.kanas,
                                            romajis: currentLesson.romajis,
                                            currentIndex: currentLesson.kanaIndex))
                                })
                                if currentLesson.currentPartNumber == currentLesson.totalParts - 1 {
                                    Button(action: {
                                        showQuiz.toggle()
                                    }, label: {
                                        ContinueLabel(
                                            widthDevice: widthDevice,
                                            heightDevice: heightDevice)
                                    })
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
