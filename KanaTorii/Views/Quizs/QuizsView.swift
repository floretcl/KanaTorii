//
//  QuizsView.swift
//  Kana Torii (iOS)
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct QuizsView: View {
    @State var pickerMode: Int = 1
    @State var pickerDifficulty: Int = 1
    @State var pickerDirection: Int = 1
    @State var pickerKanaType: Int = 1
    @State var pickerKana: Int = 1
    @State var stepperNbQuestions: Double = 10
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Quiz Mode")) {
                            Picker("Display mode", selection: $pickerMode) {
                                Text("Quiz").tag(1)
                                Text("Quick quiz").tag(2)
                            }.pickerStyle(SegmentedPickerStyle())
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
                        HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                            Spacer()
                            if pickerKanaType == 1 {
                                if pickerKana == 1 || pickerKana == 2 {
                                    Text("あ")
                                        .font(.system(size: 80))
                                } else if pickerKana == 3 {
                                    Text("が")
                                        .font(.system(size: 80))
                                } else {
                                    Text("きゃ")
                                        .font(.system(size: 80))
                                }
                                
                            } else {
                                if pickerKana == 1 || pickerKana == 2 {
                                    Text("ア")
                                        .font(.system(size: 80))
                                } else if pickerKana == 3 {
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
                                Picker("Kana selection", selection: $pickerKana) {
                                    Text("All").tag(1)
                                    Text("Gojuon").tag(2)
                                    Text("HanDakuon").tag(3)
                                    Text("Yoon").tag(4)
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                        } else {
                            Section(header: Text("QUICK QUIZ")) {
                                VStack {
                                    Text("Number of questions: \(Int(stepperNbQuestions))")
                                    Slider(
                                        value: $stepperNbQuestions,
                                        in: 5...30,
                                        step: 5,
                                        minimumValueLabel: Text("5"),
                                        maximumValueLabel: Text("30"))
                                        {
                                        Text("Number of questions: \(Int(stepperNbQuestions))")
                                        }
                                }
                            }
                        }
                        
                    }
                    NavigationLink(
                        destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                        label: {
                            Text("Start")
                                .font(.headline)
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .clipShape(Capsule())
                        }
                    ).padding(.bottom, 70)
                    Spacer()
                }
                .navigationBarTitle("Quiz", displayMode: .inline)
                .padding(.horizontal, 100)
                //.background(Color(.secondarySystemBackground))
            }.navigationViewStyle(StackNavigationViewStyle())
        } else {
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Quiz Mode")) {
                            Picker("Display mode", selection: $pickerMode) {
                                Text("Quiz").tag(1)
                                Text("Quick quiz").tag(2)
                            }.pickerStyle(SegmentedPickerStyle())
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
                        HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                            Spacer()
                            if pickerKanaType == 1 {
                                if pickerKana == 1 || pickerKana == 2 {
                                    Text("あ")
                                        .font(.system(size: 80))
                                } else if pickerKana == 3 {
                                    Text("が")
                                        .font(.system(size: 80))
                                } else {
                                    Text("きゃ")
                                        .font(.system(size: 80))
                                }
                                
                            } else {
                                if pickerKana == 1 || pickerKana == 2 {
                                    Text("ア")
                                        .font(.system(size: 80))
                                } else if pickerKana == 3 {
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
                                Picker("Kana selection", selection: $pickerKana) {
                                    Text("All").tag(1)
                                    Text("Gojuon").tag(2)
                                    Text("HanDakuon").tag(3)
                                    Text("Yoon").tag(4)
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                        } else {
                            Section(header: Text("QUICK QUIZ")) {
                                VStack {
                                    Text("Number of questions: \(Int(stepperNbQuestions))")
                                    Slider(
                                        value: $stepperNbQuestions,
                                        in: 5...30,
                                        step: 5,
                                        minimumValueLabel: Text("5"),
                                        maximumValueLabel: Text("30"))
                                        {
                                        Text("Number of questions: \(Int(stepperNbQuestions))")
                                        }
                                }
                            }
                        }
                        
                    }
                    NavigationLink(
                        destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                        label: {
                            Text("Start")
                                .font(.headline)
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .clipShape(Capsule())
                        }
                    ).padding(.bottom, 10)
                    Spacer()
                }
                .navigationBarTitle("Quiz", displayMode: .inline)
            }.navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
}

struct QuizsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuizsView()
        }
    }
}
