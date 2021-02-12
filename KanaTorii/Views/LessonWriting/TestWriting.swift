//
//  TestWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 08/02/2021.
//

import SwiftUI

struct TestWriting: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var currentLesson: Lesson
    @ObservedObject var test: TestDrawing
    @State var currentDrawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var showGuide: Bool = true
    @State var numberOfDisplayActionSheet: Int = 0
    @State var showActionSheet: Bool = false
    private var kanaType: String {
        if test.type == .hiragana {
            return "hiragana"
        } else {
            return "katakana"
        }
    }
    private var textActionSheet: String {
        if test.correctDrawing {
            return "Right Answer"
        } else {
            return "Wrong Answer"
        }
    }
    var hiraganaRecognizer: HiraganaRecognizer
    var katakanaRecognizer: KatakanaRecognizer
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            //
        } else {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    LessonHeader(currentLesson: currentLesson, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            Text("Practice drawing the kana")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                                .padding(.vertical, heightDevice/40)
                                .padding(.horizontal, 20)
                            ZStack {
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous)
                                .foregroundColor(Color(UIColor.systemBackground))
                                .shadow(color: Color("Shadow"), radius: 10, x: 0, y: 0)
                                WritingArea(
                                    currentDrawing: $currentDrawing,
                                    drawings: $drawings,
                                    color: .primary,
                                    lineWidth: widthDevice/35)
                                if showGuide {
                                    GuideWriting(romaji: test.romaji, kanaType: kanaType)
                                }
                                WritingGrid()
                            }
                            .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                            .padding(.all, heightDevice/40)
                            HStack {
                                if numberOfDisplayActionSheet == 0 {
                                    Spacer()
                                    Button(action: {
                                        showGuide.toggle()
                                    }, label: {
                                        ShowGuideButtonLabel(sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                                    })
                                }
                                Spacer()
                                Button(action: {
                                    drawings = [Drawing]()
                                }, label: {
                                    DeleteButtonLabel(sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                                })
                                .padding(.all, 10)
                                .animation(.linear)
                                Spacer()
                            }
                            Spacer()
                            Button(action: {
                                test.answerCurrentQuestion(with: "あ")
                                showActionSheet.toggle()
                            }, label: {
                                ContinueLabel(widthDevice: widthDevice, heightDevice: heightDevice)
                            })
                            .padding(.bottom, heightDevice/20)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                .navigationBarTitle(currentLesson.name)
                .edgesIgnoringSafeArea(.bottom)
            })
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(
                    title: Text(textActionSheet),
                    buttons: [
                        .default(Text("Continue"), action: {
                            numberOfDisplayActionSheet += 1
                            if numberOfDisplayActionSheet == 2 {
                                if currentLesson.nextPart == .memo {
                                    currentLesson.newPart()
                                }
                                presentation.wrappedValue.dismiss()
                            }
                            test.nextQuestion()
                            showGuide = false
                            drawings = [Drawing]()
                        })
                    ]
                )
            })
        }
    }
}

struct TestWriting_Previews: PreviewProvider {
    static var previews: some View {
        TestWriting(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana", kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]),
            test: TestDrawing(type: .hiragana, kana: "あ", romaji: "a")
        )
    }
}
