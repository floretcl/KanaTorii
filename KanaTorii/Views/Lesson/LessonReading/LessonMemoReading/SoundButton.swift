//
//  SoundButton.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct SoundButton: View {
    @StateObject var currentLesson: Lesson

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            Kana.readTextInJapanese(text: currentLesson.currentKana)
        }, label: {
            Image(systemName: "speaker.wave.2.fill")
                .font(.system(size: 40))
                .foregroundColor(.accentColor)
                .padding(5)
        })
    }
}

struct SoundButton_Previews: PreviewProvider {
    static var previews: some View {
        SoundButton(currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana",
                kanas: ["あ", "い", "う", "え", "お"],
                romajis: ["a", "i", "u", "e", "o"]))
            .previewLayout(.sizeThatFits)
    }
}
