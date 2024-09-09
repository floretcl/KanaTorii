//
//  BodyTestReading.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/03/2021.
//

import SwiftUI

struct BodyTestReading: View {
    @StateObject var currentLesson: Lesson
    @StateObject var test: Test
    private var label: String {
        if test.translationDirection == .toKana {
            return test.currentRomaji
        } else {
            return test.currentKana
        }
    }

    @Binding var showActionSheet: Bool

    let itemsCellIphone = GridItem(.flexible(minimum: 80, maximum: 140))
    let itemsCellIpad = GridItem(.flexible(minimum: 145, maximum: 210))
    
    @Binding var lessonInfoMustClose: Bool

    var body: some View {
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
                            SuggestionsTest(
                                test: test,
                                items: itemsCellIpad,
                                spacing: widthDevice/14,
                                textSize: heightDevice/24,
                                width: heightDevice/8,
                                height: heightDevice/8,
                                showActionSheet: $showActionSheet)
                                .padding(.horizontal, widthDevice/3.5)
                                .padding(.bottom, heightDevice/12)
                        } else {
                            SuggestionsTest(
                                test: test,
                                items: itemsCellIphone,
                                spacing: 30,
                                textSize: widthDevice/14,
                                width: heightDevice/8,
                                height: heightDevice/8,
                                showActionSheet: $showActionSheet)
                                .padding(.horizontal, widthDevice/6)
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

struct BodyTestReading_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BodyTestReading(
                currentLesson: Lesson(
                                name: "Lesson 1 Hiragana a i u e o | Reading",
                                mode: .reading,
                                kanaType: "hiragana", kanas: ["あ", "い", "う", "え", "お"],
                                romajis: ["a", "i", "u", "e", "o"]),
                test: Test(
                    type: .hiragana,
                    kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"],
                    currentIndex: 0),
                showActionSheet: .constant(false),
                lessonInfoMustClose: .constant(false))
            BodyTestReading(
                currentLesson: Lesson(
                    name: "Lesson 1 Hiragana a i u e o | Reading",
                    mode: .reading,
                    kanaType: "hiragana", kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"]),
                test: Test(
                    type: .hiragana,
                    kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"],
                    currentIndex: 0),
                showActionSheet: .constant(false),
                lessonInfoMustClose: .constant(false))
                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        }
    }
}
