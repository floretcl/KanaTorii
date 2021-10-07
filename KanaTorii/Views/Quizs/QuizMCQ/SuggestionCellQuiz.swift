//
//  SuggestionCellQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 24/02/2021.
//

import SwiftUI

struct SuggestionCellQuiz: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>

    @StateObject var quiz: Quiz
    @State var testDone: Bool = false

    var index: Int
    var width: CGFloat
    var height: CGFloat
    var textSize: CGFloat
    var color: Color {
        if quiz.testAnswer(with: quiz.suggestions![index]) && quiz.testDone {
            return Color("AnswerGreen")
        } else if quiz.testAnswer(with: quiz.suggestions![index]) == false && quiz.correctAnswer == false && quiz.testDone {
            return Color("AnswerRed")
        } else {
            return Color(UIColor.systemBackground)
        }
    }

    @Binding var showActionSheet: Bool

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            quiz.answerCurrentQuestion(with: quiz.suggestions![index])
            addItemToCoreData(correctAnswer: quiz.correctAnswer)
            showActionSheet.toggle()
        }, label: {
            Text(quiz.suggestions![index])
                .font(.system(size: textSize))
                .foregroundColor(.primary)
                .frame(width: width, height: height, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(color)
                        .animation(.linear)
                        .shadow(color: Color("Shadow"), radius: 2, x: 1, y: 1)
                )
        })
    }
    private func addItemToCoreData(correctAnswer: Bool) {
        var same: Bool = false
        for stat in statKana {
            if quiz.currentKana == stat.kana {
                if correctAnswer {
                    stat.nbCorrectAnswers += Float(1)
                }
                stat.nbTotalAnswers += Float(1)
                do {
                    try viewContext.save()
                } catch {
                    print(error)
                    // let nsError = error as NSError
                    // fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                same = true
            }
        }
        if same == false {
            let newStat = StatKana(context: viewContext)
            newStat.kana = quiz.currentKana
            newStat.romaji = quiz.currentRomaji
            if correctAnswer {
                newStat.nbCorrectAnswers = Float(1)
            }
            newStat.nbTotalAnswers = Float(1)
            do {
                try viewContext.save()
            } catch {
                print(error)
                // let nsError = error as NSError
                // fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct SuggestionCellQuiz_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionCellQuiz(
            quiz: Quiz(
                quickQuiz: false,
                difficulty: .easy,
                direction: .toRomaji,
                hiragana: true,
                katakana: false,
                kanaSection: .all,
                nbQuestions: 10.0),
            index: 1,
            width: 100,
            height: 100,
            textSize: 20,
            showActionSheet: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
