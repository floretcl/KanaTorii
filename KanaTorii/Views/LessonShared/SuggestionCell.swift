//
//  SuggestionCell.swift
//  KanaTorii
//
//  Created by Clément FLORET on 04/02/2021.
//

import SwiftUI

struct SuggestionCell: View {
    @ObservedObject var test: Test
    @Binding var showActionSheet: Bool
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
    var body: some View {
        Button(action: {
            test.answerCurrentQuestion(with: test.suggestions[index])
            showActionSheet.toggle()
        }, label: {
            Text(test.suggestions[index])
                .font(.system(size: textSize))
                .foregroundColor(.primary)
                .frame(width: width, height: height, alignment: .center)
                .border(Color.primary, width: 0.45)
                .background(
                    Rectangle()
                        .foregroundColor(color)
                        .animation(.linear)
                        .shadow(color: Color("Shadow"), radius: 1, x: 2, y: 2)
                )
        })
    }
}

struct SuggestionCell_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionCell(test: Test(
                            type: .hiragana,
                            kanas: ["あ","い","う","え","お"],
                            romajis: ["a","i","u","e","o"],
                            currentIndex: 0),
                       showActionSheet: .constant(false),
                       index: 1,
                       width: 100,
                       height: 100,
                       textSize: 20)
            
            
    }
}
