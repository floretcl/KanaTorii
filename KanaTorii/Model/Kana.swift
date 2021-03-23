//
//  Kana.swift
//  Kana Torii
//
//  Created by Clément FLORET on 01/01/2021.
//

import Foundation
import AVFoundation

struct Kana: Hashable, Codable, Identifiable {
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
    enum KanaType {
        case hiragana
        case katakana
    }

    static func readTextInJapanese(text: String) {
        let synthesizer = AVSpeechSynthesizer()
        let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
                try audioSession.setMode(AVAudioSession.Mode.default)
                try audioSession.setActive(true)
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            } catch {
                fatalError("Error with AVaudiosession")
            }
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        } else {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            utterance.rate = 0.1
            utterance.pitchMultiplier = 1
            utterance.volume = 1
            DispatchQueue.main.async {
                synthesizer.speak(utterance)
            }
        }
    }
    static func getIdKana(name: String) -> Int {
        let modelData = ModelData()
        var kanas: [Kana] {
            return modelData.kanas
        }
        var isFound = false
        var idKana = 0
        while isFound != true {
            for kana in kanas where kana.name == name {
                isFound = true
                idKana = kana.id
            }
        }
        return idKana
    }
    static func getLinesImageFilename(romaji: String, kanaType: KanaType) -> String {
        let modelData = ModelData()
        var kanas: [Kana] {
            return modelData.kanas
        }
        var isFound = false
        var linesImageFilename = ""
        while isFound != true {
            for kana in kanas where kana.romaji == romaji {
                isFound = true
                linesImageFilename = kanaType == .hiragana ? kana.fileNameHiraganaWithLineOrder : kana.fileNameKatakanaWithLineOrder
            }
        }
        return linesImageFilename
    }
    
}
