//
//  AboutView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct AboutView: View {
    var secondarySystemBackgroundColor: Color {
        return Color(UIColor.secondarySystemBackground)
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            VStack {
                SheetHeader(title: "About Kana: Hiragana & Katakana", systemImage: "", paddingLeading: 5)
                ScrollView {
                    Group {
                        Text("To write and read Japanese,we use Kana and Kanji, what interests us here are Kana." +
                            "They are syllabaries, which means that the Japanese language does not have an alphabet in the form we know, for most of us.")
                        Text("Hiragana and katakana are equivalent in their 'simple' form to a two-letter syllable, except for the 'n'.")
                        Text("In their simple form, hiragana and katakana consist of 46 characters of different writing with identical pronociations." +
                            "To write these characters, there is a specific order of the lines, very important." +
                            "The Hiragana are used to write the typical Japanese words and the Katakana the words of foreign origin.")
                    }
                    .frame(width: widthDevice/1.2, height: .infinity, alignment: .center)
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

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
