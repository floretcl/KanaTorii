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
            return "Right answer"
        } else {
            return "Wrong answer"
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
                            TitleTestWriting(test: test, kanaType: kanaType, heightDevice: heightDevice)
                            Spacer()
                            DrawingPadTest(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/60, romaji: test.romaji, kanaType: kanaType, showGuide: showGuide)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonsTest(drawings: $drawings, showGuide: $showGuide, test: test, sizeText: heightDevice/40, width: widthDevice/6, height: heightDevice/22)
                            Spacer()
                            ContinueButtonTestDrawing(test: test, showActionSheet: $showActionSheet, showGuide: $showGuide, drawings: $drawings, image: $image, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                .padding(.bottom, heightDevice/20)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                .navigationBarTitle(currentLesson.name)
                .edgesIgnoringSafeArea(.bottom)
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "), message: test.correctDrawing ? Text("Right answer") : Text("Wrong answer"),
                      dismissButton: .default(Text("Continue"), action: {
                    currentLesson.newPart()
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
                            TitleTestWriting(test: test, kanaType: kanaType, heightDevice: heightDevice)
                            DrawingPadTest(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/35, romaji: test.romaji, kanaType: kanaType, showGuide: showGuide)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonsTest(drawings: $drawings, showGuide: $showGuide, test: test, sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                            Spacer()
                            ContinueButtonTestDrawing(test: test, showActionSheet: $showActionSheet, showGuide: $showGuide, drawings: $drawings, image: $image, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/20)
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
                    title: test.correctDrawing ? Text("Right answer") : Text("Wrong answer"),
                    buttons: [
                        .default(Text("Continue"), action: {
                            currentLesson.newPart()
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
