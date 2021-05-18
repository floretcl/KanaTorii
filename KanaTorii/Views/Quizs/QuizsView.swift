//
//  QuizsView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 06/03/2021.
//

import SwiftUI

struct QuizsView: View {
    // User Defaults
    @AppStorage var quickQuizNbQuestions: Double

    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            QuizsViewIpad(quickQuizNbQuestions: _quickQuizNbQuestions)
        } else {
            QuizsViewIphone(quickQuizNbQuestions: _quickQuizNbQuestions)
        }
    }
}

struct QuizsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuizsView(quickQuizNbQuestions: .init(wrappedValue: 10.0, "quick-quiz-nb-questions"))
        }
    }
}
