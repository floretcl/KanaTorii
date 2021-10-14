//
//  SettingsView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 24/12/2020.
//

import SwiftUI

struct SettingsView: View {
    // User Defaults
    @AppStorage var colorsInTables: Bool
    @AppStorage var quickQuizNbQuestions: Double

    var body: some View {
        GeometryReader { geometry in
            let widthDevice = geometry.size.width
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    SheetHeaderSettings(paddingLeading: 80)
                    Spacer()
                    SettingsForm(colorsInTables: _colorsInTables, quickQuizNbQuestions: _quickQuizNbQuestions)
                        .padding(.horizontal, widthDevice/5)
                    Spacer()
                }
                .background(Color("BackgroundWithForms"))
            } else {
                VStack {
                    SheetHeaderSettings(paddingLeading: 20)
                    Spacer()
                    SettingsForm(colorsInTables: _colorsInTables, quickQuizNbQuestions: _quickQuizNbQuestions)
                    Spacer()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(colorsInTables: .init(wrappedValue: true, "colors-in-tables"), quickQuizNbQuestions: .init(wrappedValue: 10.0, "quick-quiz-nb-questions"))
            SettingsView(colorsInTables: .init(wrappedValue: true, "colors-in-tables"), quickQuizNbQuestions: .init(wrappedValue: 10.0, "quick-quiz-nb-questions"))
                .previewDevice("iPad mini (6th generation)")
        }
    }
}
