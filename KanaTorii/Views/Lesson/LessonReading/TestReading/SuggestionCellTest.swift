//
//  SuggestionCellTest.swift
//  KanaTorii
//
//  Created by Clément FLORET on 04/02/2021.
//

import SwiftUI

struct SuggestionCellTest: View {
    @StateObject var test: Test
    @State var testDone: Bool = false

    var index: Int
    var width: CGFloat
    var height: CGFloat
    var textSize: CGFloat
    var color: Color {
        if test.testAnswer(with: test.suggestions[index]) && test.testDone {
            return Color("AnswerGreen")
        } else if test.testAnswer(with: test.suggestions[index]) == false && test.correctAnswer == false && test.testDone {
            return Color("AnswerRed")
        } else {
            return Color(UIColor.systemBackground)
        }
    }

    @Binding var showActionSheet: Bool

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            test.answerCurrentQuestion(with: test.suggestions[index])
            showActionSheet.toggle()
        }, label: {
            Text(test.suggestions[index])
                .font(.system(size: textSize))
                .foregroundColor(.primary)
                .frame(width: width, height: height, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(color)
                        .animation(.linear)
                        .shadow(color: Color("Shadow"), radius: 2, x: 1, y: 1)
                    
                )
        })
    }
}

struct SuggestionCellTest_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionCellTest(
            test: Test(
                    type: .hiragana,
                    kanas: ["あ", "い", "う", "え", "お"],
                    romajis: ["a", "i", "u", "e", "o"],
                    currentIndex: 0),
            index: 1,
            width: 100,
            height: 100,
            textSize: 20,
            showActionSheet: .constant(false))
    }
}
