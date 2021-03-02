//
//  ContinueButtonTestDrawing.swift
//  KanaTorii
//
//  Created by Clément FLORET on 20/02/2021.
//

import SwiftUI

struct ContinueButtonTestDrawing: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var test: TestDrawing
    @Binding var showActionSheet: Bool
    @Binding var showGuide: Bool
    @Binding var drawings: [Drawing]
    @Binding var image: UIImage
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat

    var body: some View {
        Button(action: {
            let answer = getPrediction(uiimage: image)
            image = UIImage()
            //print(answer)
            if test.numberOfTestsPerformed > 0 {
                test.answerCurrentQuestion(with: answer)
                showActionSheet.toggle()
            } else {
                test.nextQuestion()
                showGuide = false
                drawings = [Drawing]()
            }
        }, label: {
            ContinueLabel(widthDevice: widthDevice, heightDevice: heightDevice, textSize: textSize)
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
        
        if let classLbl = test.classLabel(forImage: imageView!) {
            prediction = classLbl
        }
        return prediction
    }
}

struct ContinueButtonTestDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonTestDrawing(
            test: TestDrawing(type: .hiragana, kana: "あ", romaji: "a"),
            showActionSheet: .constant(false),
            showGuide: .constant(false),
            drawings: .constant([Drawing]()),
            image: .constant(UIImage()),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20
        )
        .previewLayout(.sizeThatFits)
    }
}