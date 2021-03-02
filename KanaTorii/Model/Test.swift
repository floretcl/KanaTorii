//
//  Test.swift
//  Kana Torii
//
//  Created by Clément FLORET on 31/01/2021.
//

import Foundation
import AudioToolbox

class Test: ObservableObject {
    private var type: KanaType
    private var kanas: [String]
    private var romajis: [String]
    private var state: State
    @Published var suggestions: [String]
    @Published var correctAnswer: Bool
    private var currentIndex: Int
    private var numberOfTestsPerformed: Int
    @Published var testDone: Bool
    enum KanaType {
        case hiragana
        case katakana
    }
    enum State {
        case play
        case end
    }
    enum Direction {
        case toKana
        case toRomaji
    }
    var currentKana: String {
        return kanas[currentIndex]
    }
    var currentRomaji: String {
        return romajis[currentIndex]
    }
    private var numberTotalKana: Int {
        return kanas.count
    }
    private var numberOfSuggestions: Int {
        if kanas.count == 5 {
            return 4
        } else {
            return 3
        }
    }
    var translationDirection: Direction {
        if numberOfTestsPerformed == 0 {
            return Direction.toRomaji
        } else {
            return Direction.toKana
        }
    }
    private var currentSolution: String {
        if translationDirection == .toRomaji {
            return currentRomaji
        } else {
            return currentKana
        }
    }
    
    init(type: KanaType, kanas: [String], romajis: [String], currentIndex: Int) {
        self.type = type
        self.kanas = kanas
        self.romajis = romajis
        self.state = .play
        self.correctAnswer = false
        self.currentIndex = currentIndex
        self.numberOfTestsPerformed = 0
        self.suggestions = []
        self.testDone = false
        suggestions = getSuggestions()
    }
    
    func answerCurrentQuestion(with answer: String) {
        if state == .play {
            let isCorrectAnswer = testAnswer(with: answer)
            if isCorrectAnswer {
                correctAnswer = true
                playSound(sound: "Correct Beep", ext: "mp3")
            } else {
                correctAnswer = false
                playSound(sound: "Wrong Beep", ext: "mp3")
            }
        }
        testDone = true
    }
    func testAnswer(with answer: String) -> Bool {
        if numberOfTestsPerformed < 2 {
            if answer.lowercased() == currentSolution.lowercased() {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    func nextQuestion() {
        numberOfTestsPerformed += 1
        if numberOfTestsPerformed == 2 {
            testEnd()
        }
        resetStateAnswer()
        suggestions = getSuggestions()
    }
    private func resetStateAnswer() {
        correctAnswer = false
        testDone = false
    }
    private func testEnd() {
        state = .end
    }
    private func getSuggestions() -> [String] {
        var characteresArray: [String]
        var characteresString: String
        if translationDirection == .toRomaji {
            characteresArray = romajis
            characteresString = currentRomaji
        } else {
            characteresArray = kanas
            characteresString = currentKana
        }
        var randomArray: [String] = []
        var randomString: String
        randomArray.append(characteresString)
        for _ in 1..<numberOfSuggestions {
            var same : Bool = true
            repeat {
                randomString = characteresArray.randomElement()!
                if randomArray.contains(randomString) {
                    same = true
                } else {
                    same = false
                }
            } while same
            randomArray.append(randomString)
        }
        return randomArray.shuffled()
    }
    private func playSound(sound: String, ext: String) {
        if let soundURL = Bundle.main.url(forResource: sound, withExtension: ext) {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }
}
