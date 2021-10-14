//
//  ContinueButtonQuizDrawing.swift
//  KanaTorii
//
//  Created by Clément FLORET on 25/02/2021.
//

import SwiftUI

struct ContinueButtonQuizDrawing: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.kana, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>

    @Environment(\.colorScheme) var colorScheme

    @StateObject var quiz: Quiz

    @Binding var drawings: [Drawing]
    @Binding var image: UIImage

    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat

    @Binding var showActionSheet: Bool

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            let answer = getPrediction(uiimage: image)
            image = UIImage()
            // print(answer)
            quiz.answerCurrentQuestion(with: answer)
            addItemToCoreData(correctAnswer: quiz.correctAnswer)
            showActionSheet.toggle()
        }, label: {
            ContinueText(widthDevice: widthDevice, heightDevice: heightDevice, textSize: textSize)
        })
    }

    func getPrediction(uiimage: UIImage) -> String {
        var imageView: UIImage?
        var prediction: String = ""

        if colorScheme == .dark {
            imageView = ImageProcessor.invertColorsImage(uiimage: uiimage)
        } else {
            imageView = uiimage
        }

        if let classLbl = quiz.classLabel(forImage: imageView!) {
            prediction = classLbl
        }
        return prediction
    }

    private func addItemToCoreData(correctAnswer: Bool) {
        var found: Bool = false
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
                found = true
            }
        }
        if found == false {
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

struct ContinueButtonQuizDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonQuizDrawing(
            quiz: Quiz(
                quickQuiz: true,
                difficulty: .hard,
                direction: .toKana,
                hiragana: false,
                katakana: true,
                kanaSection: .all,
                nbQuestions: 5.0),
            drawings: .constant([Drawing]()),
            image: .constant(UIImage()),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20,
            showActionSheet: .constant(false))
        .previewLayout(.sizeThatFits)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
