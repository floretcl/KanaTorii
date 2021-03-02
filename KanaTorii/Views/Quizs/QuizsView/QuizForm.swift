//
//  QuizForm.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct QuizForm: View {
    @Binding var pickerMode: Int
    @Binding var pickerDifficulty: Int
    @Binding var pickerDirection: Int
    @Binding var pickerKanaType: Int
    @Binding var pickerKanaSection: String
    @Binding var stepperNbQuestions: Double
    
    var body: some View {
        Form {
            Section(header: Text("Quiz Mode")) {
                Picker("Display mode", selection: $pickerMode) {
                    Text("Quiz").tag(1)
                    Text("Quick quiz").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                Text(String(pickerMode))
            }
            Section(header: Text("Difficulty")) {
                Picker("Difficulty mode", selection: $pickerDifficulty) {
                    Text("Easy").tag(1)
                    Text("Hard").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                if pickerDifficulty == 1 {
                    Text("Multiple choice questions")
                        .font(.subheadline)
                } else {
                    Text("Keyboard and drawing")
                        .font(.subheadline)
                }
            }
            Section(header: Text("Mode")) {
                Picker("Kana Type", selection: $pickerKanaType) {
                    Text("Hiragana").tag(1)
                    Text("Katakana").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                Picker("Direction mode", selection: $pickerDirection) {
                    if pickerKanaType == 1 {
                        Text("あ　-> a").tag(1)
                        Text("a -> あ").tag(2)
                    } else {
                        Text("ア　-> a").tag(1)
                        Text("a -> ア").tag(2)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                if pickerDirection == 1 && pickerKanaType == 1 {
                    Text("Hiragana Reading")
                        .font(.subheadline)
                } else if pickerDirection == 1 && pickerKanaType == 2 {
                    Text("Katakana Reading")
                        .font(.subheadline)
                } else if pickerDirection == 2 && pickerKanaType == 1 {
                    Text("Hiragana Drawing")
                        .font(.subheadline)
                } else {
                    Text("Katakana Drawing")
                        .font(.subheadline)
                }
            }
            HStack(alignment: .center, spacing: nil, content: {
                Spacer()
                if pickerKanaType == 1 {
                    if pickerKanaSection == "all" || pickerKanaSection == "gojuon" {
                        Text("あ")
                            .font(.system(size: 80))
                    } else if pickerKanaSection == "handakuon" {
                        Text("が")
                            .font(.system(size: 80))
                    } else {
                        Text("きゃ")
                            .font(.system(size: 80))
                    }
                } else {
                    if pickerKanaSection == "all" || pickerKanaSection == "gojuon" {
                        Text("ア")
                            .font(.system(size: 80))
                    } else if pickerKanaSection == "handakuon" {
                        Text("ガ")
                            .font(.system(size: 80))
                    } else {
                        Text("キャ")
                            .font(.system(size: 80))
                    }
                }
                Spacer()
            })
            if pickerMode == 1 {
                Section(header: Text("Selection")) {
                    Picker("Kana selection", selection: $pickerKanaSection) {
                        Text("All").tag("all")
                        Text("Gojuon").tag("gojuon")
                        Text("HanDakuon").tag("handakuon")
                        Text("Yoon").tag("yoon")
                    }.pickerStyle(SegmentedPickerStyle())
                }
            } else {
                Section(header: Text("QUICK QUIZ")) {
                    VStack {
                        Text("Number of questions: \(Int(stepperNbQuestions))")
                        Slider(
                            value: $stepperNbQuestions,
                            in: 10...40,
                            step: 5,
                            minimumValueLabel: Text("10"),
                            maximumValueLabel: Text("40"))
                            {
                            Text("Number of questions: \(Int(stepperNbQuestions))")
                            }
                    }
                }
            }
        }
    }
}

struct QuizForm_Previews: PreviewProvider {
    static var previews: some View {
        QuizForm(pickerMode: .constant(1), pickerDifficulty: .constant(1), pickerDirection: .constant(1), pickerKanaType: .constant(1), pickerKanaSection: .constant("all"), stepperNbQuestions: .constant(10.0))
            .previewLayout(.sizeThatFits)
    }
}
