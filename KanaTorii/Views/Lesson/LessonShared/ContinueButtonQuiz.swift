//
//  ContinueButtonQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct ContinueButtonQuiz: View {
    @StateObject var currentLesson: Lesson

    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat

    @Binding var showQuiz: Bool

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            showQuiz.toggle()
        }, label: {
            Text("Start a quick Quiz")
                .font(.system(size: textSize))
                .padding(.horizontal, widthDevice/8)
                .padding(.vertical, heightDevice/50)
                .foregroundColor(.white)
                .background(Color.orange)
                .clipShape(Capsule())
        })
    }
}

struct ContinueButtonQuiz_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonQuiz(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana",
                kanas: ["あ", "い", "う", "え", "お"],
                romajis: ["a", "i", "u", "e", "o"]),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20,
            showQuiz: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
