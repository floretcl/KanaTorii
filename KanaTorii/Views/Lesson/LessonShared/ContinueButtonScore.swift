//
//  ContinueButtonScore.swift
//  KanaTorii
//
//  Created by Clément FLORET on 02/03/2021.
//

import SwiftUI

struct ContinueButtonScore: View {
    @ObservedObject var currentLesson: Lesson
    @Binding var showScore: Bool
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat
    
    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            showScore.toggle()
        }, label: {
            Text("Show score")
                .font(.system(size: textSize))
                .padding(.horizontal, widthDevice/8)
                .padding(.vertical, heightDevice/50)
                .foregroundColor(.white)
                .background(Color.orange)
                .clipShape(Capsule())
        })
    }
}

struct ContinueButtonScore_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonScore(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana",
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]),
            showScore: .constant(false),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20)
            .previewLayout(.sizeThatFits)
    }
}
