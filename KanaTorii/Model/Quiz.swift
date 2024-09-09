//
//  Quiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import Foundation
import AudioToolbox
import SwiftUI

class Quiz: ObservableObject {
    private var modelData = ModelData()
    private var scoreData = Score()
    private var hiraganaClassifier: HiraganaClassifier?
    private var katakanaClassifier: KatakanaClassifier?
    private var quickQuiz: Bool
    private var difficulty: Difficulty
    var translationDirection: Direction
    var hiragana: Bool
    var katakana: Bool
    private var kanaSection: KanaSection
    private var nbQuestions: Double
    @Published var state: State
    private var score: Int
    @Published var testDone: Bool
    @Published var correctAnswer: Bool
    private var currentIndex: Int
    private let numberOfSuggestions: Int = 9
    @Published var suggestions: [String]?
    @Published var kanas: [Kana] = []
    enum Difficulty {
        case easy
        case hard
    }
    enum Direction {
        case toRomaji
        case toKana
    }
    enum KanaSection {
        case all
        case gojuon
        case handakuon
        case yoon
    }
    enum State {
        case play
        case end
       }
    var currentKana: String {
        if hiragana {
            return kanas[currentIndex].hiragana
        } else {
            return kanas[currentIndex].katakana
        }
    }
    var currentRomaji: String {
        return kanas[currentIndex].romaji
    }
    var currentName: String {
        return kanas[currentIndex].name
    }
    var numberTotalKana: Int {
        return kanas.count
    }
    var currentSolution: String {
        if translationDirection == .toRomaji {
            return currentName
        } else {
            return currentKana
        }
    }
    private var currentSolutionIfRomaji: String {
        if difficulty == .hard && translationDirection == .toRomaji {
            return currentRomaji
        } else {
            return "false"
        }
    }
    var currentQuestion: Int {
        return currentIndex + 1
    }
    var currentProgression: Double {
        return (Double(currentQuestion)) / Double(kanas.count)
    }

    init(quickQuiz: Bool, difficulty: Difficulty, direction: Direction, hiragana: Bool, katakana: Bool, kanaSection: KanaSection, nbQuestions: Double) {
        self.quickQuiz = quickQuiz
        self.difficulty = difficulty
        self.translationDirection = direction
        self.hiragana = hiragana
        self.katakana = katakana
        self.kanaSection = kanaSection
        self.nbQuestions = nbQuestions
        self.state = .play
        self.score = 0
        self.testDone = false
        self.correctAnswer = false
        self.currentIndex = 0
        if self.quickQuiz {
            kanas = getRandomKana()
        } else {
            switch self.kanaSection {
            case .all:
                kanas = modelData.kanas.shuffled()
            case .gojuon:
                kanas = modelData.gojuons.shuffled()
            case .handakuon:
                kanas = modelData.handakuons.shuffled()
            case .yoon:
                kanas = modelData.yoons.shuffled()
            }
        }
        if self.difficulty == .easy {
            suggestions = getSuggestions()
        } else if difficulty == .hard && translationDirection == .toKana {
            initializeConfiguration()
        }
    }

    func answerCurrentQuestion(with answer: String) {
        if state == .play {
            let isCorrectAnswer = testAnswer(with: answer)
            if isCorrectAnswer {
                score += 1
                correctAnswer = true
                playSound(sound: "Correct Beep", ext: "mp3")
            } else {
                correctAnswer = false
                playSound(sound: "Wrong Beep", ext: "mp3")
            }
        }
        testDone = true
        if currentIndex == kanas.count - 1 {
            quizEnd()
        }
        saveScore()
    }

    func testAnswer(with answer: String) -> Bool {
        if answer.lowercased() == currentSolution.lowercased() || answer.lowercased() == currentSolutionIfRomaji.lowercased() {
            return true
        } else {
            return false
        }
    }

    func nextQuestion() {
        if currentIndex < kanas.count {
            currentIndex += 1
        }
        resetStateAnswer()
        if difficulty == .easy {
            suggestions = getSuggestions()
        }
    }
    
    func addOneToScore() {
        score += 1
        saveScore()
    }

    private func resetStateAnswer() {
        correctAnswer = false
        testDone = false
    }

    private func quizEnd() {
        state = .end
    }

    private func saveScore() {
        scoreData.nbCorrectAnswers = score
        scoreData.nbTotalQuestions = numberTotalKana
    }

    private func getRandomKana() -> [Kana] {
        let kanas: [Kana] = modelData.kanas.shuffled()
        var randomArray: [Kana] = []
        for iteration in 0..<Int(nbQuestions) {
            randomArray.append(kanas[iteration])
        }
        return randomArray
    }

    private func getSuggestions() -> [String] {
        let currentKanaElement: Kana = kanas[currentIndex]
        var randomArrayElement: [Kana] = []
        var randomElement: Kana
        var randomArray: [String] = []

        randomArrayElement.append(currentKanaElement)
        for _ in 1..<numberOfSuggestions {
            var same: Bool = true
            repeat {
                randomElement = kanas.randomElement()!
                if randomArrayElement.contains(randomElement) {
                    same = true
                } else {
                    same = false
                }
            } while same
            randomArrayElement.append(randomElement)
        }
        for element in randomArrayElement {
            if translationDirection == .toRomaji {
                randomArray.append(element.name)
            } else if translationDirection == .toKana && hiragana {
                randomArray.append(element.hiragana)
            } else {
                randomArray.append(element.katakana)
            }
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
        if hiragana {
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

    // Return prediction from CoreML Model
    func classLabel(forImage: UIImage) -> String? {
        var prediction: String
        guard let cGImage = forImage.cgImage else {
            return nil
        }
        guard let pixelbuffer = ImageProcessor.pixelBuffer(forImage: cGImage) else {
            return nil
        }
        if hiragana {
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
