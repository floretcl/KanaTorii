//
//  MiniQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import Foundation
import AVFoundation
import SwiftUI

class MiniQuiz: ObservableObject {
    private var hiraganaClassifier: HiraganaClassifier?
    private var katakanaClassifier: KatakanaClassifier?
    private var draw: Bool
    var type: KanaType
    private var kanas: [String]
    private var romajis: [String]
    @Published var state: State
    private var arrayIndex: [Int]
    private var cycle: Int
    @Published var testDone: Bool
    @Published var correctAnswer: Bool
    private var currentIndex: Int
    @Published var suggestions: [String]?
    private var randomNumberGenerator = SystemRandomNumberGenerator()
    private let nbSuggestionIf5possibility: Int = 4
    private let nbSuggestionIf3possibility: Int = 3
    enum KanaType {
        case hiragana
        case katakana
    }
    enum Direction {
        case toRomaji
        case toKana
    }
    enum State {
        case play
        case end
   }
    var currentKana: String {
        return kanas[arrayIndex[currentIndex]]
    }
    var currentRomaji: String {
        return romajis[arrayIndex[currentIndex]]
    }
    var numberTotalKana: Int {
        return kanas.count
    }
    var numberOfSuggestions: Int {
        if kanas.count == 5 {
            return nbSuggestionIf5possibility
        } else {
            return nbSuggestionIf3possibility
        }
    }
    var translationDirection: Direction {
        if draw {
            return Direction.toKana
        } else {
            if currentIndex % 2 == 0 {
                return Direction.toRomaji
            } else {
                return Direction.toKana
            }
        }
    }
    var currentSolution: String {
        if translationDirection == .toRomaji {
            return currentRomaji
        } else {
            return currentKana
        }
    }
    var currentQuestion: Int {
        return currentIndex + 1
    }
    var currentProgression: Double {
        return (Double(currentIndex)) / Double(kanas.count)
    }

    init(type: KanaType, kanas: [String], romajis: [String], draw: Bool) {
        self.draw = draw
        self.type = type
        self.kanas = kanas
        self.romajis = romajis
        self.state = .play
        self.cycle = 1
        self.testDone = false
        self.correctAnswer = false
        self.currentIndex = 0
        self.suggestions = []

        if kanas.count == 5 {
            arrayIndex = [0, 1, 2, 3, 4].shuffled()
        } else {
            arrayIndex = [0, 1, 2].shuffled()
        }

        if self.draw == false {
            suggestions = getSuggestions()
        } else {
            initializeConfiguration()
        }
        
        Kana.readTextInJapanese(text: currentKana)
        print("initialisation")
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
        if currentIndex == kanas.count - 1 && cycle == 2 {
            quizEnd()
        } else if currentIndex == kanas.count - 1 && cycle == 1 {
            cycle += 1
        }
    }

    func testAnswer(with answer: String) -> Bool {
        if answer.lowercased() == currentSolution.lowercased() {
            return true
        } else {
            return false
        }
    }

    func nextQuestion() {
        if currentIndex == kanas.count - 1 && cycle == 2 {
            currentIndex = 0
        } else if currentIndex < kanas.count {
            currentIndex += 1
        }
        resetStateAnswer()
        if self.draw == false {
            suggestions = getSuggestions()
        }
        Kana.readTextInJapanese(text: currentKana)
    }
    
    private func resetStateAnswer() {
        correctAnswer = false
        testDone = false
    }

    private func quizEnd() {
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
            var same: Bool = true
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
            AudioServicesPlaySystemSound(mySound)
        }
    }

    // Initialize for CoreML Model use
    private func initializeConfiguration() {
        if type == .hiragana {
            do {
                try hiraganaClassifier = HiraganaClassifier(configuration: .init())
            } catch {
                fatalError("Error to init model")
            }
        } else {
            do {
                try katakanaClassifier = KatakanaClassifier(configuration: .init())
            } catch {
                fatalError("Error to init model")
            }
        }
    }

    // Return prediction form right CoreML Model
    func classLabel(forImage: UIImage) -> String? {
        var prediction: String
        guard let cGImage = forImage.cgImage else {
            return nil
        }
        guard let pixelbuffer = ImageProcessor.pixelBuffer(forImage: cGImage) else {
            return nil
        }
        if type == .hiragana {
            do {
                try prediction = hiraganaClassifier?.prediction(image: pixelbuffer).classLabel ?? ""
            } catch {
                fatalError("Unexpected runtime error: \(error)")
            }
        } else {
            do {
                try prediction = katakanaClassifier?.prediction(image: pixelbuffer).classLabel ?? ""
            } catch {
                fatalError("Unexpected runtime error: \(error)")
            }
        }
        return prediction
    }
}
