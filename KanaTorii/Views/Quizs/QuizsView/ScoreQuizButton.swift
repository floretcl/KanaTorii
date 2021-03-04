//
//  ScoreQuizButton.swift
//  KanaTorii
//
//  Created by Clément FLORET on 01/03/2021.
//

import SwiftUI

struct ScoreQuizButton: View {
    @Binding var showScore: Bool
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat
    
    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            showScore.toggle()
        }, label: {
            Text("Show Score")
                .font(.system(size: textSize))
                .padding(.horizontal, widthDevice/6)
                .padding(.vertical, heightDevice/50)
                .foregroundColor(.white)
                .background(Color.orange)
                .clipShape(Capsule())
        })
    }
}

struct ScoreQuizButton_Previews: PreviewProvider {
    static var previews: some View {
        ScoreQuizButton(
            showScore: .constant(false),
            widthDevice: 300,
            heightDevice: 600,
            textSize: 20
        ).previewLayout(.sizeThatFits)
    }
}
