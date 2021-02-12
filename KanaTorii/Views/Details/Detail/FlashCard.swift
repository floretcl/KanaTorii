//
//  FlashCard.swift
//  Kana Torii
//
//  Created by Clément FLORET on 04/01/2021.
//

import SwiftUI

struct FlashCard: View {
    var kanaType: String
    var label: String
    var otherLabel: String
    var romaji: String
    var heightDevice: CGFloat
    private var otherKanaType: String {
        if kanaType == "hiragana" {
            return "katakana"
        } else {
            return "hiragana"
        }
    }
    
    var body: some View {
        VStack {
            Text("\(kanaType)")
                .font(.system(size: heightDevice/28))
            Text("\(label)")
                .font(.custom("YuMincho", size: heightDevice/9))
                .padding(.bottom, heightDevice/350)
            Group {
                HStack {
                    Group {
                        Text("\(otherKanaType) :")
                        Text("\(otherLabel)")
                    }.font(.system(size: heightDevice/28))
                }
                HStack {
                    Group {
                        Text("romaji :")
                        Text("\(romaji)")
                    }.font(.system(size: heightDevice/28))
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .frame(width: heightDevice/3.5, height: heightDevice/3.5, alignment: .center)
                .foregroundColor(Color(UIColor.tertiarySystemBackground))
                .shadow(color: Color.black, radius: 2, x: 1, y: 3)
                .padding(.bottom, 10)
        )
    }
}

struct FlashCard_Previews: PreviewProvider {
    static var previews: some View {
        FlashCard( kanaType: "hiragana", label: "あ", otherLabel: "ア", romaji: "a", heightDevice: 800)
    }
}
