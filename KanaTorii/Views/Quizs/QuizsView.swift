//
//  QuizsView.swift
//  Kana Torii (iOS)
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct QuizsView: View {
    @ObservedObject var userSettings = UserSettings()
    @State var pickerMode: Int = 1
    @State var pickerDifficulty: Int = 1
    @State var pickerDirection: Int = 1
    @State var pickerKanaType: Int = 1
    @State var pickerKanaSection: String = "all"
    @State var showQuiz: Bool = false
    @State var showScore: Bool = false
    @State var quizIsDone: Bool = false
    var quickQuiz: Bool {
        if pickerMode == 2 {
            return true
        } else {
            return false
        }
    }
    var hiragana: Bool {
        if pickerKanaType == 1 {
            return true
        } else {
            return false
        }
    }
    var katakana: Bool {
        if pickerKanaType == 2 {
            return true
        } else {
            return false
        }
    }
    var kanaSection: Quiz.KanaSection {
        if pickerKanaSection == "gojuon" {
            return .gojuon
        } else if pickerKanaSection == "handakuon" {
            return .handakuon
        } else if pickerKanaSection == "yoon" {
            return .yoon
        } else {
            return .all
        }
    }
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                NavigationView {
                    VStack {
                        Form {
                            Section(header: Text("Quiz Mode")) {
                                Picker("Display mode", selection: $pickerMode) {
                                    Text("Quiz").tag(1)
                                    Text("Quick quiz").tag(2)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: pickerMode, perform: { _ in
                                    hapticFeedback(style: .soft)
                                })
                            }
                            Section(header: Text("Difficulty")) {
                                Picker("Difficulty mode", selection: $pickerDifficulty) {
                                    Text("Easy").tag(1)
                                    Text("Hard").tag(2)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: pickerDifficulty, perform: { _ in
                                    hapticFeedback(style: .soft)
                                })
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
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: pickerKanaType, perform: { _ in
                                    hapticFeedback(style: .soft)
                                })
                                Picker("Direction mode", selection: $pickerDirection) {
                                    if pickerKanaType == 1 {
                                        Text("あ　-> a").tag(1)
                                        Text("a -> あ").tag(2)
                                    } else {
                                        Text("ア　-> a").tag(1)
                                        Text("a -> ア").tag(2)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: pickerDirection, perform: { _ in
                                    hapticFeedback(style: .soft)
                                })
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
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .onChange(of: pickerKanaSection, perform: { _ in
                                        hapticFeedback(style: .soft)
                                    })
                                }
                            } else {
                                Section(header: Text("QUICK QUIZ")) {
                                    VStack {
                                        Text("Number of questions: \(Int(userSettings.quickQuizNbQuestions))")
                                        Slider(
                                            value: $userSettings.quickQuizNbQuestions,
                                            in: 10...40,
                                            step: 5,
                                            onEditingChanged: { _ in
                                                hapticFeedback(style: .soft)
                                            },
                                            minimumValueLabel: Text("10"),
                                            maximumValueLabel: Text("40"))
                                            {
                                            Text("Number of questions: \(Int(userSettings.quickQuizNbQuestions))")
                                            }
                                    }
                                }
                            }
                            HStack {
                                Spacer()
                                ZStack {
                                    StartQuizButton(showQuiz: $showQuiz, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                        .fullScreenCover(
                                            isPresented: $showQuiz,
                                            onDismiss: {
                                                quizIsDone.toggle()
                                                showScore.toggle()
                                            },
                                            content: {
                                                if pickerDifficulty == 1 && pickerDirection == 1 {
                                                    QuizMCQKanaToRomaji(quiz: Quiz(quickQuiz: quickQuiz, difficulty: .easy, direction: .toRomaji, hiragana: hiragana, katakana: katakana, kanaSection: kanaSection, nbQuestions: userSettings.quickQuizNbQuestions))
                                                } else if pickerDifficulty == 1 && pickerDirection == 2 {
                                                    QuizMCQRomajiToKana(quiz: Quiz(quickQuiz: quickQuiz, difficulty: .easy, direction: .toKana, hiragana: hiragana, katakana: katakana, kanaSection: kanaSection, nbQuestions: userSettings.quickQuizNbQuestions))
                                                } else if pickerDifficulty == 2 && pickerDirection == 1 {
                                                    QuizKeyboard(quiz: Quiz(quickQuiz: quickQuiz, difficulty: .hard, direction: .toRomaji, hiragana: hiragana, katakana: katakana, kanaSection: kanaSection, nbQuestions: userSettings.quickQuizNbQuestions))
                                                } else {
                                                    QuizWriting(quiz: Quiz(quickQuiz: quickQuiz, difficulty: .hard, direction: .toKana, hiragana: hiragana, katakana: katakana, kanaSection: kanaSection, nbQuestions: userSettings.quickQuizNbQuestions))
                                                }
                                            }
                                        )
                                        .padding(.vertical, 10)
                                    if quizIsDone {
                                        ScoreQuizButton(showScore: $showScore, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                            .sheet(
                                                isPresented: $showScore,
                                                onDismiss: {quizIsDone.toggle()},
                                                content: {
                                                ScoreView()
                                                }
                                            )
                                        .padding(.vertical, 5)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .navigationBarTitle("Quiz", displayMode: .inline)
                    .padding(.horizontal, 100)
                    //.background(Color(.secondarySystemBackground))
                }.navigationViewStyle(StackNavigationViewStyle())
            }).onAppear(perform: {
                userSettings.quickQuizNbQuestions = UserDefaults.standard.object(forKey: "quick-quiz-nb-questions") as? Double ?? 10.0
            })
        } else {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                let heightDevice = geometry.size.height
                NavigationView {
                    VStack {
                        Form {
                            Section(header: Text("Quiz Mode")) {
                                Picker("Display mode", selection: $pickerMode) {
                                    Text("Quiz").tag(1)
                                    Text("Quick quiz").tag(2)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: pickerMode, perform: { _ in
                                    hapticFeedback(style: .soft)
                                })
                            }
                            Section(header: Text("Difficulty")) {
                                Picker("Difficulty mode", selection: $pickerDifficulty) {
                                    Text("Easy").tag(1)
                                    Text("Hard").tag(2)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: pickerDifficulty, perform: { _ in
                                    hapticFeedback(style: .soft)
                                })
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
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: pickerKanaType, perform: { _ in
                                    hapticFeedback(style: .soft)
                                })
                                Picker("Direction mode", selection: $pickerDirection) {
                                    if pickerKanaType == 1 {
                                        Text("あ　-> a").tag(1)
                                        Text("a -> あ").tag(2)
                                    } else {
                                        Text("ア　-> a").tag(1)
                                        Text("a -> ア").tag(2)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: pickerDirection, perform: { _ in
                                    hapticFeedback(style: .soft)
                                })
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
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .onChange(of: pickerKanaSection, perform: { _ in
                                        hapticFeedback(style: .soft)
                                    })
                                }
                            } else {
                                Section(header: Text("QUICK QUIZ")) {
                                    VStack {
                                        Text("Number of questions: \(Int(userSettings.quickQuizNbQuestions))")
                                        Slider(
                                            value: $userSettings.quickQuizNbQuestions,
                                            in: 10...40,
                                            step: 5,
                                            onEditingChanged: {_ in
                                                hapticFeedback(style: .soft)
                                            },
                                            minimumValueLabel: Text("10"),
                                            maximumValueLabel: Text("40"))
                                            {
                                            Text("Number of questions: \(Int(userSettings.quickQuizNbQuestions))")
                                            }
                                    }
                                }
                            }
                            HStack {
                                Spacer()
                                ZStack {
                                    StartQuizButton(showQuiz: $showQuiz, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                        .fullScreenCover(
                                            isPresented: $showQuiz,
                                            onDismiss: {
                                                quizIsDone.toggle()
                                                showScore.toggle()},
                                            content: {
                                                if pickerDifficulty == 1 && pickerDirection == 1 {
                                                    QuizMCQKanaToRomaji(quiz: Quiz(quickQuiz: quickQuiz, difficulty: .easy, direction: .toRomaji, hiragana: hiragana, katakana: katakana, kanaSection: kanaSection, nbQuestions: userSettings.quickQuizNbQuestions))
                                                } else if pickerDifficulty == 1 && pickerDirection == 2 {
                                                    QuizMCQRomajiToKana(quiz: Quiz(quickQuiz: quickQuiz, difficulty: .easy, direction: .toKana, hiragana: hiragana, katakana: katakana, kanaSection: kanaSection, nbQuestions: userSettings.quickQuizNbQuestions))
                                                } else if pickerDifficulty == 2 && pickerDirection == 1 {
                                                    QuizKeyboard(quiz: Quiz(quickQuiz: quickQuiz, difficulty: .hard, direction: .toRomaji, hiragana: hiragana, katakana: katakana, kanaSection: kanaSection, nbQuestions: userSettings.quickQuizNbQuestions))
                                                } else {
                                                    QuizWriting(quiz: Quiz(quickQuiz: quickQuiz, difficulty: .hard, direction: .toKana, hiragana: hiragana, katakana: katakana, kanaSection: kanaSection, nbQuestions: userSettings.quickQuizNbQuestions))
                                                }
                                            }
                                        )
                                        .padding(.vertical, 5)
                                    if quizIsDone {
                                        ScoreQuizButton(showScore: $showScore, widthDevice: widthDevice, heightDevice: heightDevice, textSize: widthDevice/33)
                                            .sheet(
                                                isPresented: $showScore,
                                                onDismiss: {quizIsDone.toggle()},
                                                content: {
                                                    ScoreView()
                                                }
                                            )
                                        .padding(.vertical, 5)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .navigationBarTitle("Quiz", displayMode: .inline)
                }.navigationViewStyle(StackNavigationViewStyle())
            }).onAppear(perform: {
                userSettings.quickQuizNbQuestions = UserDefaults.standard.object(forKey: "quick-quiz-nb-questions") as? Double ?? 10.0
            })
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
