//
//  Score.swift
//  KanaTorii
//
//  Created by Clément FLORET on 01/03/2021.
//

import Foundation

class Score: ObservableObject {
    @Published var nbCorrectAnswers: Int {
        didSet {
            UserDefaults.standard.set(nbCorrectAnswers, forKey: "nb-correct-answers")
        }
    }
    @Published var nbTotalQuestions: Int {
        didSet {
            UserDefaults.standard.set(nbTotalQuestions, forKey: "nb-total-questions")
        }
    }
    
    init() {
        self.nbCorrectAnswers = UserDefaults.standard.object(forKey: "nb-correct-answers") as? Int ?? 0
        self.nbTotalQuestions = UserDefaults.standard.object(forKey: "nb-total-questions") as? Int ?? 0
    }
}
