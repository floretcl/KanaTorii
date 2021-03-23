//
//  BodyTestReading.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/03/2021.
//

import SwiftUI

struct BodyTestReading: View {
    @ObservedObject var currentLesson: Lesson
    @ObservedObject var test: Test
    private var label: String {
        if test.translationDirection == .toKana {
            return test.currentRomaji
        } else {
            return test.currentKana
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
                            SuggestionsTest(
                                test: test,
                                items: itemsCellIpad,
                                spacing: 35,
                                textSize: heightDevice/24,
                                width: 175,
                                height: 175,
                                showActionSheet: $showActionSheet)
                                .padding(.bottom, heightDevice/8)
                        } else {
                            SuggestionsTest(
                                test: test,
                                items: itemsCellIphone,
                                spacing: 30,
                                textSize: widthDevice/14,
                                width: 100,
                                height: 100,
                                showActionSheet: $showActionSheet)
                                .padding(.bottom, heightDevice/8)
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
        BodyTestReading(
            currentLesson: Lesson(
                            name: "Lesson 1 Hiragana a i u e o | Reading",
                            mode: .reading,
                            kanaType: "hiragana", kanas: ["あ","い","う","え","お"],
                            romajis: ["a","i","u","e","o"]),
            test: Test(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                currentIndex: 0),
            showActionSheet: .constant(false))
    }
}
