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
    private var parts: [LessonPart] {
        let memo = LessonPart.memo
        let test = LessonPart.test
        let quiz = LessonPart.quiz
        let score = LessonPart.score
        if kanas.count == 5 {
            return [memo, test, memo, test, memo, test, memo, test, memo, test, quiz, score]
        } else {
            return [memo, test, memo, test, memo, test, quiz, score]
        }

    }
    var totalParts: Int {
        return parts.count
    }
    var currentPart: LessonPart {
        return parts[currentPartIndex]
    }
    private var nextPart: LessonPart {
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
        state = .play
        currentPartIndex = 0
        numberOfMemo = 0
        numberOfTest = 0
        numberOfQuiz = 0
        numberOfScore = 0
        kanaIndex = 0
    }
}
