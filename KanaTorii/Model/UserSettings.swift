//
//  UserSettings.swift
//  KanaTorii
//
//  Created by Clément FLORET on 01/03/2021.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var colorsInTables: Bool {
        didSet {
            UserDefaults.standard.set(colorsInTables, forKey: "colors-in-tables")
        }
    }
    @Published var quickQuizNbQuestions: Double {
        didSet {
            UserDefaults.standard.set(quickQuizNbQuestions, forKey: "quick-quiz-nb-questions")
        }
    }
    
    init() {
        self.colorsInTables = UserDefaults.standard.object(forKey: "colors-in-tables") as? Bool ?? true
        self.quickQuizNbQuestions = UserDefaults.standard.object(forKey: "quick-quiz-nb-questions") as? Double ?? 10.0
    }
}
