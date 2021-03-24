//
//  TestDrawing.swift
//  KanaTorii
//
//  Created by Clément FLORET on 08/02/2021.
//

import Foundation
import AudioToolbox
import SwiftUI
import CoreML

class TestDrawing: ObservableObject {
    private var hiraganaRecognizer: HiraganaRecognizer?
    private var katakanaRecognizer: KatakanaRecognizer?
    private var kana: String
    @Published var type: KanaType
    @Published var romaji: String
    private var state: State
    @Published var correctDrawing: Bool
    @Published var numberOfTestsPerformed: Int
    private var testDone: Bool
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
    private var mode: Mode {
        if self.numberOfTestsPerformed == 0 {
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
        
        initializeConfiguration()
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
    
    private func testAnswer(with answer: String) -> Bool {
        if answer.lowercased() == kana.lowercased() {
            return true
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
    }
    
    private func resetStateAnswer() {
        correctDrawing = false
        testDone = false
    }
    
    private func testEnd() {
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
    
    // Initialize for CoreML Model use
    private func initializeConfiguration() {
        if type == .hiragana {
            do {
                try hiraganaRecognizer = HiraganaRecognizer(configuration: .init())
            } catch {
                fatalError("Error to init model")
            }
        } else {
            do {
                try katakanaRecognizer = KatakanaRecognizer(configuration: .init())
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
                try prediction = hiraganaRecognizer?.prediction(image: pixelbuffer).classLabel ?? ""
            } catch {
                fatalError("Unexpected runtime error: \(error)")
            }
        } else {
            do {
                try prediction = katakanaRecognizer?.prediction(image: pixelbuffer).classLabel ?? ""
            } catch {
                fatalError("Unexpected runtime error: \(error)")
            }
        }
        return prediction
    }
}
