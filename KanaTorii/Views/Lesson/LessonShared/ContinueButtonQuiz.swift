//
//  ContinueButtonQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct ContinueButtonQuiz: View {
    @ObservedObject var currentLesson: Lesson
    @Binding var showQuiz: Bool
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat
    
    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            showQuiz.toggle()
        }, label: {
            Text("Quiz")
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
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]),
            showQuiz: .constant(false),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20)
            .previewLayout(.sizeThatFits)
    }
}
