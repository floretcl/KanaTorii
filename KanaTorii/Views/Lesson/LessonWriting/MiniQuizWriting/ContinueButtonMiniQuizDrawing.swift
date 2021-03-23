//
//  ContinueButtonMiniQuizDrawing.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct ContinueButtonMiniQuizDrawing: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var miniQuiz: MiniQuiz
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
            //print(answer)
            miniQuiz.answerCurrentQuestion(with: answer)
            addItemToCoreData(correctAnswer: miniQuiz.correctAnswer)
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
        
        if let classLbl = miniQuiz.classLabel(forImage: imageView!) {
            prediction = classLbl
        }
        return prediction
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
                    //let nsError = error as NSError
                    //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
                //let nsError = error as NSError
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContinueButtonMiniQuizDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonMiniQuizDrawing(
            miniQuiz: MiniQuiz(
                type: .hiragana,
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"],
                draw: true),
            drawings: .constant([Drawing]()),
            image: .constant(UIImage()),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20,
            showActionSheet: .constant(false))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .previewLayout(.sizeThatFits)
    }
}
