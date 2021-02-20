//
//  SoundButton.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct SoundButton: View {
    @ObservedObject var currentLesson: Lesson
    
    var body: some View {
        Button(action: {
            currentLesson.readTextInJapanese(text: currentLesson.currentKana)
        }, label: {
            SoundImage(sizeText: 40)
        })
    }
}

struct SoundButton_Previews: PreviewProvider {
    static var previews: some View {
        SoundButton(currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana",
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]))
            .previewLayout(.sizeThatFits)
    }
}
