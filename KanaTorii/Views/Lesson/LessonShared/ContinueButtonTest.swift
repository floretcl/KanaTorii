//
//  ContinueButtonTest.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct ContinueButtonTest: View {
    @ObservedObject var currentLesson: Lesson
    @Binding var showTest: Bool
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat
    
    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            currentLesson.newPart()
            showTest.toggle()
        }, label: {
            ButtonLabel(
                widthDevice: widthDevice,
                heightDevice: heightDevice, textSize: textSize, text: "Continue")
        })
    }
}

struct ContinueButtonTest_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonTest(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana",
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]),
            showTest: .constant(false),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20)
            .previewLayout(.sizeThatFits)
    }
}
