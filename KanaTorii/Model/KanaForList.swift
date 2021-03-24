//
//  KanaForList.swift
//  Kana Torii
//
//  Created by Clément FLORET on 16/01/2021.
//

import Foundation

struct KanaForList: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var romaji: String
    var hiragana: String
    var katakana: String
    var isGojuon: Bool
    var isDakuonHandakuon: Bool
    var isYoon: Bool
    var fileNameHiraganaWithLineOrder: String
    var fileNameKatakanaWithLineOrder: String
    var isKana: Bool {
        if self.name != "" {
            return true
        } else {
            return false
        }
    }
}
