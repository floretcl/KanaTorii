//
//  LessonForList.swift
//  Kana Torii
//
//  Created by Clément FLORET on 27/01/2021.
//

import Foundation

struct LessonForList: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var type: String
    var kanas: [String]
    var romaji: [String]
    var text: String
    var isHiragana: Bool {
        if title.contains("Hiragana") {
            return true
        } else {
            return false
        }
    }
    var isKatakana: Bool {
        if title.contains("Katakana") {
            return true
        } else {
            return false
        }
    }
    var kanaTypeString: String {
        return isHiragana ? "hiragana" : "katakana"
    }
}
