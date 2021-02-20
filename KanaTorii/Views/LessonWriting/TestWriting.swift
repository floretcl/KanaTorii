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
    @ObservedObject var currentLesson: Lesson
    @ObservedObject var test: TestDrawing
    @State var drawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var showGuide: Bool = true
    @State var showActionSheet: Bool = false
    @State var image: UIImage = UIImage()
    private var kanaType: String {
        if test.type == .hiragana {
            return "hiragana"
        } else {
            return "katakana"
        }
    }
    private var textActionSheet: String {
        if test.correctDrawing {
            return "Correct drawing"
        } else {
            return "Incorrect drawing"
        }
    }
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                VStack {
                    LessonHeader(currentLesson: currentLesson, heightDevice: heightDevice)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        VStack {
                            TitleLesson(heightDevice: heightDevice, text: "Practice drawing the \(kanaType): \(test.romaji.uppercased())")
                            Spacer()
                            DrawingPadTest(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/60, romaji: test.romaji, kanaType: kanaType, showGuide: showGuide)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonsTest(drawings: $drawings, showGuide: $showGuide, test: test, sizeText: widthDevice/35, width: widthDevice/6, height: heightDevice/22)
                            Spacer()
                            ContinueButtonTestDrawing(test: test, showActionSheet: $showActionSheet, showGuide: $showGuide, drawings: $drawings, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33, image: image)
                                .padding(.bottom, heightDevice/20)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                .navigationBarTitle(currentLesson.name)
                .edgesIgnoringSafeArea(.bottom)
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "), message: Text(textActionSheet), dismissButton: .default(Text("Continue"), action: {
                    if currentLesson.nextPart == .memo {
                        currentLesson.newPart()
                    }
                    test.nextQuestion()
                    showGuide = false
                    drawings = [Drawing]()
                    presentation.wrappedValue.dismiss()
                    })
                )
            })
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
                            TitleLesson(heightDevice: heightDevice, text: "Practice drawing the \(kanaType): \(test.romaji.uppercased())")
                            DrawingPadTest(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/35, romaji: test.romaji, kanaType: kanaType, showGuide: showGuide)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonsTest(drawings: $drawings, showGuide: $showGuide, test: test, sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                            Spacer()
                            ContinueButtonTestDrawing(test: test, showActionSheet: $showActionSheet, showGuide: $showGuide, drawings: $drawings, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20, image: image)
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
                            if currentLesson.nextPart == .memo {
                                currentLesson.newPart()
                            }
                            test.nextQuestion()
                            showGuide = false
                            drawings = [Drawing]()
                            presentation.wrappedValue.dismiss()
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
                    kanaType: "hiragana", kanas: ["あ","い","う","え","お"],
                    romajis: ["a","i","u","e","o"]),
                test: TestDrawing(type: .hiragana, kana: "あ", romaji: "a")
            )
        }
    }
}
