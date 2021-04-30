//
//  ContinueButtonTestDrawing.swift
//  KanaTorii
//
//  Created by Clément FLORET on 20/02/2021.
//

import SwiftUI

struct ContinueButtonTestDrawing: View {
    @Environment(\.colorScheme) var colorScheme

    @StateObject var test: TestDrawing

    @Binding var showGuide: Bool
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
            if test.numberOfTestsPerformed == 0 {
                showGuide = false
                drawings = [Drawing]()
                test.nextQuestion()
            } else {
                test.answerCurrentQuestion(with: answer)
                showActionSheet.toggle()
            }
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
            showGuide: .constant(false),
            drawings: .constant([Drawing]()),
            image: .constant(UIImage()),
            widthDevice: 320,
            heightDevice: 830,
            textSize: 20,
            showActionSheet: .constant(false))
        .previewLayout(.sizeThatFits)
    }
}
