//
//  TestWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 08/02/2021.
//

import SwiftUI
import CoreML

struct TestWriting: View {
    @Environment(\.presentationMode) var presentation

    @StateObject var currentLesson: Lesson
    @StateObject var test: TestDrawing
    private var kanaType: String {
        if test.type == .hiragana {
            return "hiragana"
        } else {
            return "katakana"
        }
    }

    @State var drawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var image: UIImage = UIImage()
    @State var showGuide: Bool = true

    @Binding var showQuiz: Bool
    @State var showActionSheet: Bool = false
    
    @Binding var lessonInfoMustClose: Bool

    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    LessonHeader(
                        currentLesson: currentLesson,
                        lessonInfoMustClose: $lessonInfoMustClose,
                        heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleTestWriting(test: test, kanaType: kanaType, heightDevice: heightDevice)
                            Spacer()
                            DrawingPadTest(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: 15, romaji: test.romaji, kanaType: kanaType, showGuide: showGuide)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonsTest(test: test, drawings: $drawings, showGuide: $showGuide, sizeText: heightDevice/40, width: heightDevice/5, height: heightDevice/22, widthSpace: widthDevice/44)
                            Spacer()
                            ContinueButtonTestDrawing(
                                test: test,
                                showGuide: $showGuide,
                                drawings: $drawings,
                                image: $image,
                                widthDevice: widthDevice,
                                heightDevice: heightDevice,
                                textSize: heightDevice/40,
                                showActionSheet: $showActionSheet)
                                .padding(.bottom, heightDevice/20)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                .navigationBarTitle(currentLesson.name)
                .edgesIgnoringSafeArea(.bottom)
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(
                    title: Text("Your result: "),
                    message: test.correctDrawing ? Text("Right answer") : Text("Not recognized"),
                    primaryButton: .default(Text("Validate anyway"), action: {
                        currentLesson.newPart()
                        drawings = [Drawing]()
                        if currentLesson.currentPart == .quiz {
                            showQuiz.toggle()
                        }
                        self.presentation.wrappedValue.dismiss()
                    }),
                    secondaryButton: .destructive(Text("Continue"), action: {
                        currentLesson.newPart()
                        drawings = [Drawing]()
                        if currentLesson.currentPart == .quiz {
                            showQuiz.toggle()
                        }
                        self.presentation.wrappedValue.dismiss()
                    })
                )
            })
        } else {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    LessonHeader(
                        currentLesson: currentLesson,
                        lessonInfoMustClose: $lessonInfoMustClose,
                        heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleTestWriting(test: test, kanaType: kanaType, heightDevice: heightDevice)
                            DrawingPadTest(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/40, romaji: test.romaji, kanaType: kanaType, showGuide: showGuide)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonsTest(test: test, drawings: $drawings, showGuide: $showGuide, sizeText: widthDevice/22, width: heightDevice/5, height: heightDevice/22, widthSpace: widthDevice/40)
                            Spacer()
                            ContinueButtonTestDrawing(
                                test: test,
                                showGuide: $showGuide,
                                drawings: $drawings,
                                image: $image,
                                widthDevice: widthDevice,
                                heightDevice: heightDevice,
                                textSize: heightDevice/40,
                                showActionSheet: $showActionSheet)
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
                    title: test.correctDrawing ? Text("Right answer") : Text("Not recognized"),
                    buttons: [
                        .default(Text("Validate anyway"), action: {
                            currentLesson.newPart()
                            drawings = [Drawing]()
                            if currentLesson.currentPart == .quiz {
                                showQuiz.toggle()
                            }
                            self.presentation.wrappedValue.dismiss()
                        }),
                        .destructive(Text("Continue"), action: {
                            currentLesson.newPart()
                            drawings = [Drawing]()
                            if currentLesson.currentPart == .quiz {
                                showQuiz.toggle()
                            }
                            self.presentation.wrappedValue.dismiss()
                        })
                    ]
                )
            })
        }
    }
}

struct TestWriting_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestWriting(
                currentLesson: Lesson(
                    name: "Lesson 1 Hiragana a i u e o | Reading",
                    mode: .reading,
                    kanaType: "hiragana", kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"]),
                test: TestDrawing(type: .hiragana, kana: "あ", romaji: "a"),
                showQuiz: .constant(false),
                lessonInfoMustClose: .constant(false)
            )
        }
    }
}
