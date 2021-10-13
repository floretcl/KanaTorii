//
//  MiniQuizWriting.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI
import CoreML

struct MiniQuizWriting: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext

    @Environment(\.presentationMode) var presentation

    @StateObject var currentLesson: Lesson
    @StateObject var miniQuiz: MiniQuiz
    private var kanaType: String {
        if miniQuiz.type == .hiragana {
            return "hiragana"
        } else {
            return "katakana"
        }
    }

    @State var drawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var image: UIImage = UIImage()

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
                            TitleMiniQuizWriting(miniQuiz: miniQuiz, kanaType: kanaType, heightDevice: heightDevice)
                            Spacer()
                            DrawingPadQuiz(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: 15)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonQuiz(drawings: $drawings, sizeText: heightDevice/40, width: heightDevice/5, height: heightDevice/22)
                            Spacer()
                            ContinueButtonMiniQuizDrawing(
                                miniQuiz: miniQuiz,
                                drawings: $drawings,
                                image: $image,
                                widthDevice: widthDevice,
                                heightDevice: heightDevice,
                                textSize: heightDevice/40,
                                showActionSheet: $showActionSheet)
                                .environment(\.managedObjectContext, self.viewContext)
                                .padding(.bottom, heightDevice/20)
                        }
                        Spacer()
                    }
                }.background(Color(UIColor.secondarySystemBackground))
                .navigationBarTitle(currentLesson.name)
                .edgesIgnoringSafeArea(.bottom)
            })
            .alert(isPresented: $showActionSheet, content: {
                Alert(title: Text("Your result: "),
                      message: miniQuiz.correctAnswer ? Text("Right answer: \(miniQuiz.currentSolution.uppercased())") : Text("Not recognized: \(miniQuiz.currentSolution.uppercased())"),
                      dismissButton: .default(Text("Continue"), action: {
                        drawings = [Drawing]()
                        if miniQuiz.state == .play {
                            miniQuiz.nextQuestion()
                        } else {
                            self.presentation.wrappedValue.dismiss()
                        }
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
                            TitleMiniQuizWriting(miniQuiz: miniQuiz, kanaType: kanaType, heightDevice: heightDevice)
                            DrawingPadQuiz(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/40)
                                .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                                .padding(.all, heightDevice/40)
                            DrawingButtonQuiz(drawings: $drawings, sizeText: widthDevice/22, width: heightDevice/5, height: heightDevice/22)
                            Spacer()
                            ContinueButtonMiniQuizDrawing(
                                miniQuiz: miniQuiz,
                                drawings: $drawings,
                                image: $image,
                                widthDevice: widthDevice,
                                heightDevice: heightDevice,
                                textSize: heightDevice/40,
                                showActionSheet: $showActionSheet)
                                .environment(\.managedObjectContext, self.viewContext)
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
                    title: miniQuiz.correctAnswer ? Text("Right answer: \(miniQuiz.currentSolution.uppercased())") : Text("Not recognized: \(miniQuiz.currentSolution.uppercased())"),
                    buttons: [
                        .default(Text("Continue"), action: {
                            drawings = [Drawing]()
                            if miniQuiz.state == .play {
                                miniQuiz.nextQuestion()
                            } else {
                                self.presentation.wrappedValue.dismiss()
                            }
                        })
                    ]
                )
            })
        }
    }
}

struct MiniQuizWriting_Previews: PreviewProvider {
    static var previews: some View {
        MiniQuizWriting(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana", kanas: ["あ", "い", "う", "え", "お"],
                romajis: ["a", "i", "u", "e", "o"]),
            miniQuiz: MiniQuiz(
                type: .hiragana,
                kanas: ["あ", "い", "う", "え", "お"],
                romajis: ["a", "i", "u", "e", "o"],
                draw: true),
            lessonInfoMustClose: .constant(false)
        )
    }
}
