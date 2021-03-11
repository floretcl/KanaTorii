//
//  SuggestionCellTestQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct SuggestionCellTestQuiz: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>
    @ObservedObject var quizForTest: QuizForTest
    @Binding var showActionSheet: Bool
    @State var testDone: Bool = false
    var index: Int
    var width: CGFloat
    var height: CGFloat
    var textSize: CGFloat
    var color: Color {
        if quizForTest.testAnswer(with: quizForTest.suggestions![index]) && quizForTest.testDone {
            return Color("AnswerGreen")
        } else if quizForTest.testAnswer(with: quizForTest.suggestions![index]) == false && quizForTest.correctAnswer == false && quizForTest.testDone {
            return Color("AnswerRed")
        } else {
            return Color(UIColor.systemBackground)
        }
    }
    
    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            quizForTest.answerCurrentQuestion(with: quizForTest.suggestions![index])
            addItemToCoreData(correctAnswer: quizForTest.correctAnswer)
            showActionSheet.toggle()
        }, label: {
            Text(quizForTest.suggestions![index])
                .font(.system(size: textSize))
                .foregroundColor(.primary)
                .frame(width: width, height: height, alignment: .center)
                .border(Color.primary, width: 0.45)
                .background(
                    Rectangle()
                        .foregroundColor(color)
                        .animation(.linear)
                        .shadow(color: Color("Shadow"), radius: 1, x: 2, y: 2)
                )
        })
    }
    private func addItemToCoreData(correctAnswer: Bool) {
        var same: Bool = false
        for stat in statKana {
            if quizForTest.currentKana == stat.kana {
                if correctAnswer {
                    stat.nbCorrectAnswers += Float(1)
                }
                stat.nbTotalAnswers += Float(1)
                do {
                    try viewContext.save()
                } catch {
                    print(error)
                    //let nsError = error as NSError
                    //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                same = true
            }
        }
        if same == false {
            let newStat = StatKana(context: viewContext)
            newStat.kana = quizForTest.currentKana
            newStat.romaji = quizForTest.currentRomaji
            if correctAnswer {
                newStat.nbCorrectAnswers = Float(1)
            }
            newStat.nbTotalAnswers = Float(1)
            do {
                try viewContext.save()
            } catch {
                print(error)
                //let nsError = error as NSError
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct SuggestionCellTestQuiz_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionCellTestQuiz(quizForTest: QuizForTest(
                                    type: .hiragana,
                                    kanas: ["あ","い","う","え","お"],
                                romajis: ["a","i","u","e","o"],
                                draw: false),
                               showActionSheet: .constant(false),
                               index: 1,
                               width: 100,
                               height: 100,
                               textSize: 20)
    }
}
