//
//  TestDrawing.swift
//  KanaTorii
//
//  Created by Clément FLORET on 08/02/2021.
//

import Foundation
import AVFoundation

class TestDrawing: ObservableObject {
    var type: KanaType
    var kana: String
    var romaji: String
    @Published var state: State
    @Published var correctDrawing: Bool
    var numberOfTestsPerformed: Int
    @Published var testDone: Bool
    enum KanaType {
        case hiragana
        case katakana
    }
    enum State {
        case play
        case end
    }
    enum Mode {
        case practice
        case test
    }
    var mode: Mode {
        if numberOfTestsPerformed == 0 {
            return Mode.practice
        } else {
            return Mode.test
        }
    }
    init(type: KanaType, kana: String, romaji: String) {
        self.type = type
        self.kana = kana
        self.romaji = romaji
        self.state = .play
        self.numberOfTestsPerformed = 0
        self.correctDrawing = false
        self.testDone = false
    }
    func answerCurrentQuestion(with answer: String) {
        if state == .play {
            let iscorrectDrawing = testAnswer(with: answer)
            if iscorrectDrawing {
                correctDrawing = true
                playSound(sound: "Correct Beep", ext: "mp3")
            } else {
                correctDrawing = false
                playSound(sound: "Wrong Beep", ext: "mp3")
            }
        }
        testDone = true
    }
    func testAnswer(with answer: String) -> Bool {
        if numberOfTestsPerformed < 2 {
            if answer.lowercased() == kana.lowercased() {
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
            testfinished()
        }
        resetStateAnswer()
    }
    private func resetStateAnswer() {
        correctDrawing = false
        testDone = false
    }
    private func testfinished() {
        state = .end
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
