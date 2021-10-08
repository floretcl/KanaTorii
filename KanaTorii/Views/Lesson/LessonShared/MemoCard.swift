//
//  MemoCard.swift
//  Kana Torii
//
//  Created by Clément FLORET on 03/02/2021.
//

import SwiftUI

struct MemoCard: View {
    @StateObject var currentLesson: Lesson
    var fileNameLinesImage: String {
        return getLinesImageFilename(romaji: currentLesson.currentRomaji, kanaType: currentLesson.kanaType)
    }

    var widthDevice: CGFloat
    var heightDevice: CGFloat

    var body: some View {
        if currentLesson.mode == .reading {
            VStack {
                Text(currentLesson.kanaType)
                    .font(.system(size: heightDevice/25))
                    .padding(.top, heightDevice/40)
                Text(currentLesson.currentKana)
                    .font(.custom("YuMincho", size: heightDevice/10))
                    .padding(.vertical, heightDevice/60)
                HStack {
                    Text("Romaji :")
                        .font(.system(size: heightDevice/25))
                    Text(currentLesson.currentRomaji.capitalized)
                        .font(.system(size: heightDevice/22))
                        .fontWeight(.semibold)
                }.padding(.bottom, heightDevice/30)
            }
            .padding(.horizontal, widthDevice/12)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(UIColor.tertiarySystemBackground))
                    .shadow(color: Color.black, radius: 2, x: 1, y: 3)
                    .padding(.bottom, 10)
            )
        } else {
            VStack {
                Text(currentLesson.kanaType)
                    .font(.system(size: heightDevice/25))
                    .padding(.top, heightDevice/40)
                    Image(fileNameLinesImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: heightDevice/4, alignment: .center)
                HStack {
                    Text("Romaji :")
                        .font(.system(size: heightDevice/25))
                    Text(currentLesson.currentRomaji.capitalized)
                        .font(.system(size: heightDevice/22))
                        .fontWeight(.semibold)
                }.padding(.bottom, heightDevice/30)
            }
            .padding(.horizontal, widthDevice/10)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(UIColor.tertiarySystemBackground))
                    .shadow(color: Color.black, radius: 2, x: 1, y: 3)
                    .padding(.bottom, 10)
            )
        }
    }

    func getLinesImageFilename(romaji: String, kanaType: String) -> String {
        return Kana.getLinesImageFilename(romaji: romaji, kanaType: kanaType == "hiragana" ? .hiragana : .katakana)
    }
}

struct MemoCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemoCard(currentLesson: Lesson(
                        name: "Lesson 1 Hiragana a i u e o | Reading",
                        mode: .reading,
                        kanaType: "hiragana",
                        kanas: ["あ", "い", "う", "え", "お"],
                        romajis: ["a", "i", "u", "e", "o"]),
                     widthDevice: 420,
                 heightDevice: 830)
            MemoCard(currentLesson: Lesson(
                        name: "Lesson 1 Hiragana a i u e o | Reading",
                        mode: .writing,
                        kanaType: "hiragana",
                        kanas: ["あ", "い", "う", "え", "お"],
                        romajis: ["a", "i", "u", "e", "o"]),
                     widthDevice: 420,
                 heightDevice: 830)
        }
    }
}
