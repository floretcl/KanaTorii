//
//  FlashCard.swift
//  Kana Torii
//
//  Created by Clément FLORET on 04/01/2021.
//

import SwiftUI

struct FlashCard: View {
    var type: String
    var label: String
    var otherLabel: String
    var romaji: String
    private var otherType: String {
        if type == "hiragana" {
            return "katakana"
        } else {
            return "hiragana"
        }
    }
    var heightDevice: CGFloat

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("\(type.capitalized)")
                    .font(.system(size: heightDevice/30))
                Text("\(label)")
                    .font(.custom("YuMincho", size: heightDevice/10))
                    .padding(.bottom, heightDevice/350)
                Group {
                    HStack {
                        Group {
                            Text("\(otherType) :")
                            Text("\(otherLabel)")
                        }.font(.system(size: heightDevice/30))
                    }
                    HStack {
                        Group {
                            Text("romaji :")
                            Text("\(romaji)")
                        }.font(.system(size: heightDevice/30))
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
            Spacer()
        }
    }
}

struct FlashCard_Previews: PreviewProvider {
    static var previews: some View {
        FlashCard(type: "hiragana", label: "あ", otherLabel: "ア", romaji: "a", heightDevice: 800)
    }
}
