//
//  SuggestionCellMiniQuiz.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct SuggestionCellMiniQuiz: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>

    @StateObject var miniQuiz: MiniQuiz

    var index: Int
    var width: CGFloat
    var height: CGFloat
    var textSize: CGFloat
    var color: Color {
        if miniQuiz.testAnswer(with: miniQuiz.suggestions![index]) && miniQuiz.testDone {
            return Color("AnswerGreen")
        } else if miniQuiz.testAnswer(with: miniQuiz.suggestions![index]) == false && miniQuiz.correctAnswer == false && miniQuiz.testDone {
            return Color("AnswerRed")
        } else {
            return Color(UIColor.systemBackground)
        }
    }

    @State var testDone: Bool = false
    @Binding var showActionSheet: Bool

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            miniQuiz.answerCurrentQuestion(with: miniQuiz.suggestions![index])
            addItemToCoreData(correctAnswer: miniQuiz.correctAnswer)
            showActionSheet.toggle()
        }, label: {
            Text(miniQuiz.suggestions![index])
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
            if miniQuiz.currentKana == stat.kana {
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
            newStat.kana = miniQuiz.currentKana
            newStat.romaji = miniQuiz.currentRomaji
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

struct SuggestionCellMiniQuiz_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionCellMiniQuiz(miniQuiz: MiniQuiz(
                                    type: .hiragana,
                                    kanas: ["あ", "い", "う", "え", "お"],
                                romajis: ["a", "i", "u", "e", "o"],
                                draw: false),
                               index: 1,
                               width: 100,
                               height: 100,
                               textSize: 20,
                               showActionSheet: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
