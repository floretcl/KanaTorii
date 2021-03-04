//
//  StartQuizButton.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/02/2021.
//

import SwiftUI

struct StartQuizButton: View {
    @Binding var showQuiz: Bool
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    var textSize: CGFloat
    
    var body: some View {
        Button(action: {
            hapticFeedback(style: .soft)
            showQuiz.toggle()
        }, label: {
            Text("Start")
                .font(.system(size: textSize))
                .shadow(color: Color.black, radius: 4, x: 0.0, y: 2.0)
                .padding(.horizontal, widthDevice/6)
                .padding(.vertical, heightDevice/50)
                .foregroundColor(.white)
                .background(Color.orange)
                .clipShape(Capsule())
        })
    }
}

struct StartQuizButton_Previews: PreviewProvider {
    static var previews: some View {
        StartQuizButton(
            showQuiz: .constant(false),
            widthDevice: 300,
            heightDevice: 600,
            textSize: 20
        ).previewLayout(.sizeThatFits)
    }
}
