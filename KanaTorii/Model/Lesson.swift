//
//  Lesson.swift
//  Kana Torii
//
//  Created by Clément FLORET on 31/01/2021.
//

import Foundation
import AVFoundation

class Lesson: ObservableObject {
    var name: String
    var mode: Mode
    var kanaType: String
    @Published var kanas: [String]
    @Published var romajis: [String]
    @Published var kanaIndex: Int
    var currentPartIndex: Int
    @Published var numberOfMemo: Int
    @Published var numberOfTest: Int
    @Published var numberOfQuiz: Int
    @Published var numberOfScore: Int
    @Published var state: State
    enum LessonPart {
        case memo
        case test
        case quiz
        case score
    }
    enum State {
        case play
        case end
    }
    enum Mode {
        case reading
        case writing
    }
    var parts: [LessonPart] {
        let memo = LessonPart.memo
        let test = LessonPart.test
        let quiz = LessonPart.quiz
        let score = LessonPart.score
        if kanas.count == 5 {
            return [memo,test,memo,test,memo,test,memo,test,memo,test,quiz,score]
        } else {
            return [memo,test,memo,test,memo,test,quiz,score]
        }
        
    }
    var totalParts: Int {
        return parts.count
    }
    var currentPart: LessonPart {
        return parts[currentPartIndex]
    }
    var nextPart: LessonPart {
        return parts[currentPartIndex + 1]
    }
    var currentKana: String {
        return kanas[kanaIndex]
    }
    var currentRomaji: String {
        return romajis[kanaIndex]
    }
    var currentPartNumber: Int {
        return currentPartIndex + 1
    }
    var currentProgression: Double {
        return (Double(currentPartNumber)) / Double(parts.count)
    }
    
    
    init(name: String, mode: Mode, kanaType: String, kanas: [String], romajis: [String]) {
        self.name = name
        self.mode = mode
        self.kanaType = kanaType
        self.kanas = kanas
        self.romajis = romajis
        self.state = .play
        self.currentPartIndex = 0
        self.numberOfMemo = 0
        self.numberOfTest = 0
        self.numberOfQuiz = 0
        self.numberOfScore = 0
        self.kanaIndex = 0
    }
    func newPart() {
        if currentPartIndex + 1 < totalParts {
            currentPartIndex += 1
            if currentPart == .memo {
                kanaIndex = currentPartIndex - numberOfTest - numberOfQuiz
            } else if currentPart == .test {
                numberOfTest += 1
            } else if currentPart == .quiz {
                numberOfQuiz += 1
            } else if currentPart == .score {
                numberOfScore += 1
            }
        } else {
            lessonFinished()
        }
    }
    func lessonFinished() {
        state = .end
    }
    func reset() {
        self.state = .play
        self.currentPartIndex = 0
        self.numberOfMemo = 0
        self.numberOfTest = 0
        self.numberOfQuiz = 0
        self.numberOfScore = 0
        self.kanaIndex = 0
    }
    func readTextInJapanese(text: String) {
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
}
