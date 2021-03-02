//
//  IntroductionView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct IntroductionView: View {
    var secondarySystemBackgroundColor: Color {
        return Color(UIColor.secondarySystemBackground)
    }
    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            VStack {
                SheetHeader(title: "Introduction to Kana Torii", systemImage: "questionmark.circle.fill", paddingLeading: 5)
                ScrollView {
                    Group {
                        Text("The first step in learning Japanese is to know how to read and write." +
                            " In Japan, two syllabaries are used for this: Hiragana and Katakana, called Kana, and ideograms, called Kanji.\nTo learn kana there is no secret, you have to learn them by heart.")
                        Text("This application aims to help you in learning kana. For that, to make the task easier there is in this application a section 'lessons'." +
                            " It allows you to learn step by step to recognize hiragana and then katakana. It is very practical and it is advisable to repeat them.")
                        Text("For an overview, you can go to the 'hiragana' and 'katakana' sections, see a particular character, know its writing, listen to its pronunciation and practice writing it." +
                            " Finally a Quiz section will allow you to practice when you get to know hiragana and katakana better.")
                    }
                    .frame(width: widthDevice/1.2, alignment: .center)
                    .padding(.vertical, 20)
                    .font(.body)
                    .lineSpacing(5)
                    .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .background(secondarySystemBackgroundColor)
            .edgesIgnoringSafeArea(.bottom)
        })
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}
