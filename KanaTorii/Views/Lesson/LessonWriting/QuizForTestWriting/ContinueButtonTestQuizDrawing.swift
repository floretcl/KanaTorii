//
//  ContinueButtonTestQuizDrawing.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct ContinueButtonTestQuizDrawing: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var quizForTest: QuizForTest
    @Binding var showActionSheet: Bool
    @Binding var drawings: [Drawing]
    @Binding var image: UIImage
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat
    
    

    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            let answer = getPrediction(uiimage: image)
            image = UIImage()
            //print(answer)
            quizForTest.answerCurrentQuestion(with: answer)
            addItemToCoreData(correctAnswer: quizForTest.correctAnswer)
            showActionSheet.toggle()
        }, label: {
            Text("Continue")
                .font(.system(size: textSize))
                .padding(.horizontal, widthDevice/8)
                .padding(.vertical, heightDevice/50)
                .foregroundColor(.white)
                .background(Color.orange)
                .clipShape(Capsule())
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
        
        if let classLbl = quizForTest.classLabel(forImage: imageView!) {
            prediction = classLbl
        }
        return prediction
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

struct ContinueButtonTestQuizDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonTestQuizDrawing(
            quizForTest: QuizForTest(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                draw: true
            ),
            showActionSheet: .constant(false),
            drawings: .constant([Drawing]()),
            image: .constant(UIImage()),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20
        )
        .previewLayout(.sizeThatFits)
    }
}
