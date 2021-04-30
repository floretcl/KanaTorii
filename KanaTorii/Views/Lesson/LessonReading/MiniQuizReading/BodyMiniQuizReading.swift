//
//  BodyMiniQuizReading.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/03/2021.
//

import SwiftUI

struct BodyMiniQuizReading: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var currentLesson: Lesson
    @StateObject var miniQuiz: MiniQuiz

    private var label: String {
        if miniQuiz.translationDirection == .toKana {
            return miniQuiz.currentRomaji
        } else {
            return miniQuiz.currentKana
        }
    }

    @Binding var showActionSheet: Bool

    let itemsCellIphone = GridItem(.fixed(120))
    let itemsCellIpad = GridItem(.fixed(200))

    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            VStack {
                LessonHeader(currentLesson: currentLesson, heightDevice: heightDevice)
                    .padding(.top, 5)
                HStack {
                    Spacer()
                    VStack {
                        TitleTestReading(heightDevice: heightDevice)
                        if UIDevice.current.localizedModel == "iPad" {
                            Text(label)
                                .font(.system(size: heightDevice/7))
                                .padding(heightDevice/35)
                        } else {
                            Text(label)
                                .font(.system(size: heightDevice/5))
                        }
                        Spacer()
                        if UIDevice.current.localizedModel == "iPad" {
                            SuggestionsMiniQuiz(miniQuiz: miniQuiz, items: itemsCellIpad, spacing: 35, width: 175, height: 175, textSize: heightDevice/24, showActionSheet: $showActionSheet)
                                .environment(\.managedObjectContext, self.viewContext)
                                .padding(.bottom, heightDevice/8)
                        } else {
                            SuggestionsMiniQuiz(miniQuiz: miniQuiz, items: itemsCellIphone, spacing: 30, width: 100, height: 100, textSize: widthDevice/14, showActionSheet: $showActionSheet)
                                .environment(\.managedObjectContext, self.viewContext)
                                .padding(.bottom, heightDevice/10)
                        }
                    }
                    Spacer()
                }
            }.background(Color(UIColor.secondarySystemBackground))
            .navigationBarTitle(currentLesson.name)
            .edgesIgnoringSafeArea(.bottom)
        })
    }
}

struct BodyMiniQuizReading_Previews: PreviewProvider {
    static var previews: some View {
        BodyMiniQuizReading(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana", kanas: ["あ", "い", "う", "え", "お"],
                romajis: ["a", "i", "u", "e", "o"]),
            miniQuiz: MiniQuiz(
                type: .hiragana,
                kanas: ["あ", "い", "う", "え", "お"],
                romajis: ["a", "i", "u", "e", "o"],
                draw: false),
            showActionSheet: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
