//
//  ContinueButtonTestLessonMemo.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct ContinueButtonTestLessonMemo: View {
    @ObservedObject var currentLesson: Lesson
    @Binding var showTest: Bool
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    
    var body: some View {
        Button(action: {
            showTest.toggle()
            currentLesson.newPart()
        }, label: {
            ContinueLabel(
                widthDevice: widthDevice,
                heightDevice: heightDevice)
        })
    }
}

struct ContinueButtonTestLessonMemo_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonTestLessonMemo(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana",
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]),
            showTest: .constant(false),
            widthDevice: 320,
            heightDevice: 830)
            .previewLayout(.sizeThatFits)
    }
}
