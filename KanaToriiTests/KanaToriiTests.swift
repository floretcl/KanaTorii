//
//  KanaToriiTests.swift
//  KanaToriiTests
//
//  Created by Clément FLORET on 03/02/2021.
//

import XCTest
@testable import KanaTorii

class KanaToriiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    // TEST FOR LESSON.SWIFT
    func testGivenInstanceOfLessonIsCreate_ThenCurrentPartIsMemo() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])


        XCTAssertTrue(lesson.currentPart == .memo)
    }
    func testGivenInstanceOfLessonIsCreate_ThenCurrentRomajiIsA() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])


        XCTAssertTrue(lesson.currentRomaji == "a")
    }
    func testGivenInstanceOfLessonIsCreate_WhenNewPart_ThenKanaIndexIsEqualTo0() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])

        lesson.newPart()

        XCTAssertTrue(lesson.kanaIndex == 0)
    }
    func testGivenInstanceOfLessonIsCreate_WhenNewPart_ThenCurrentPartIndexIsEqualTo1() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])

        lesson.newPart()

        XCTAssertTrue(lesson.currentPartIndex == 1)
    }
    func testGivenInstanceOfLessonIsCreate_WhenNewPart_ThenCurrentPartIsTest() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])

        lesson.newPart()

        XCTAssertTrue(lesson.currentPart == .test)
    }
    func testGivenInstanceOfLessonIsCreate_WhenNewPart_ThenCurrentRomajiIsA() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])

        lesson.newPart()

        XCTAssertTrue(lesson.currentRomaji == "a")
    }
    func testGivenCurrentPartIsTest_WhenNewPart_ThenCurrentPartIsMemo() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])
        lesson.newPart()

        lesson.newPart()

        XCTAssertTrue(lesson.currentPart == .memo)
    }
    func testGivenCurrentPartIsTest_WhenNewPart_ThenCurrentPartIndexIs2() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])
        lesson.newPart()

        lesson.newPart()

        XCTAssertTrue(lesson.currentPartIndex == 2)
    }
    func testGivenCurrentPartIsTest_WhenNewPart_ThenNumberOfTestIs1() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])
        lesson.newPart()

        lesson.newPart()

        XCTAssertTrue(lesson.numberOfTest == 1)
    }
    func testGivenCurrentPartIsTest_WhenNewPart_ThenKanaIndexIs1() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])
        lesson.newPart()

        lesson.newPart()

        XCTAssertTrue(lesson.kanaIndex == 1)
    }
    func testGivenCurrentPartIsTest_WhenNewPart_ThenCurrentRomajiIsI() {
        let lesson = Lesson(
            name: "Lesson 1 Hiragana a i u e o | Reading",
            mode: .reading,
            kanaType: "hiragana",
            kanas: ["あ","い","う","え","お"],
            romajis: ["a","i","u","e","o"])
        lesson.newPart()

        lesson.newPart()

        XCTAssertTrue(lesson.currentRomaji == "i")
    }
    
    
    
    
    
     // TEST FOR TEST.SWIFT
    func testWhenInstanceOfTestIsCreate_ThenSuggestionsAreCreated() {
        let test = Test(type: .hiragana, kanas: ["あ","い","う","え","お"], romajis: ["a","i","u","e","o"], currentIndex: 0)

        XCTAssertTrue(test.suggestions != [])
    }
//    func testWhenInstanceOfTestIsCreate_ThenSuggestionsareAreAllDifferents() {
//        let test = Test(type: .hiragana, kanas: ["あ","い","う","え","お"], romajis: ["a","i","u","e","o"], currentIndex: 0)
//        var same : Bool = false
//        for i in 0..<test.numberOfSuggestions {
//            if i == 0 {
//                if test.suggestions[i] == test.suggestions[i+1] || test.suggestions[i] == test.suggestions[i+2] || test.suggestions[i] == test.suggestions[i+3] {
//                    same = true
//                }
//            }
//            else if i == 1 {
//                if test.suggestions[i] == test.suggestions[i+1] || test.suggestions[i] == test.suggestions[i+2] {
//                    same = true
//                }
//            }
//            else if i == 2 {
//                if test.suggestions[i] == test.suggestions[i+1] {
//                    same = true
//                }
//            }
//        }
//        XCTAssertTrue(same != true)
//    }
    func testGivenInstanceOfTestIsCreate_WhenAnswerCurrentQuestionWithCorrectAnswer_ThenCorrectAnswerIsTrue() {
        let test = Test(type: .hiragana, kanas: ["あ","い","う","え","お"], romajis: ["a","i","u","e","o"], currentIndex: 0)

        test.answerCurrentQuestion(with: "a")

        XCTAssertTrue(test.correctAnswer == true)
    }
    func testGivenInstanceOfTestIsCreate_WhenAnswerCurrentQuestionWithWrongAnswer_ThenCorrectAnswerIsFalse() {
        let test = Test(type: .hiragana, kanas: ["あ","い","う","え","お"], romajis: ["a","i","u","e","o"], currentIndex: 0)

        test.answerCurrentQuestion(with: "i")

        XCTAssertTrue(test.correctAnswer == false)
    }
//    func testGivenNumberOfTestsPerformedIsEaqual1_WhenNumberOfTestsPerformedIsEqual2_ThenTestEnd() {
//        let test = Test(type: .hiragana, kanas: ["あ","い","う","え","お"], romajis: ["a","i","u","e","o"], currentIndex: 0)
//        test.answerCurrentQuestion(with: "あ")
//        test.nextQuestion()
//
//        test.answerCurrentQuestion(with: "あ")
//        test.nextQuestion()
//
//        XCTAssertTrue(test.state == .end)
//    }
    
    // TEST FOR QUIZ.SWIFT
    func testGivenQuizInstanceCreate_WhenQuickQuiz_ThenKanasCountIsEqualToNbQuestions() {
        let quiz = Quiz(quickQuiz: true, difficulty: .easy, direction: .toKana, hiragana: true, katakana: false, kanaSection: .all, nbQuestions: 25.0)
        
        XCTAssertTrue(Int(quiz.nbQuestions) == quiz.kanas.count)
    }
    func testGivenQuizInstanceCreate_WhenGetSuggestions_ThenNineSuggestions() {
        let quiz = Quiz(quickQuiz: true, difficulty: .easy, direction: .toKana, hiragana: true, katakana: false, kanaSection: .all, nbQuestions: 25.0)
        
        XCTAssertTrue(quiz.suggestions?.count == quiz.numberOfSuggestions)
    }
    func testGivenQuizInstanceCreate_WhenAllKana_Then104Questions() {
        let quiz = Quiz(quickQuiz: false, difficulty: .easy, direction: .toKana, hiragana: true, katakana: false, kanaSection: .all, nbQuestions: 25.0)
        
        XCTAssertTrue(quiz.numberTotalKana == 104)
    }
    func testGivenQuizInstanceCreate_WhenGojuonKana_Then46Questions() {
        let quiz = Quiz(quickQuiz: false, difficulty: .easy, direction: .toKana, hiragana: true, katakana: false, kanaSection: .gojuon, nbQuestions: 25.0)
        
        XCTAssertTrue(quiz.numberTotalKana == 46)
    }
    func testGivenQuizInstanceCreate_WhenHandakuonKana_Then25Questions() {
        let quiz = Quiz(quickQuiz: false, difficulty: .easy, direction: .toKana, hiragana: true, katakana: false, kanaSection: .handakuon, nbQuestions: 25.0)
        
        XCTAssertTrue(quiz.numberTotalKana == 25)
    }
    func testGivenQuizInstanceCreate_WhenYoonKana_Then33Questions() {
        let quiz = Quiz(quickQuiz: false, difficulty: .easy, direction: .toKana, hiragana: true, katakana: false, kanaSection: .yoon, nbQuestions: 25.0)
        
        XCTAssertTrue(quiz.numberTotalKana == 33)
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
