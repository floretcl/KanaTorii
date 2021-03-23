//
//  QuizHeader.swift
//  KanaTorii
//
//  Created by Clément FLORET on 25/02/2021.
//

import SwiftUI

struct QuizHeader: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var quiz: Quiz
    @Binding var showScore: Bool
    var heightDevice: CGFloat
    
    var body: some View {
        HStack {
            Button(action: {
                showScore.toggle()
                presentation.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "multiply")
                    .font(.title)
                    .padding(.leading, 10)
            })
            VStack {
                Text("Part \(quiz.currentQuestion) / \(quiz.kanas.count)"  )
                    .padding(.top, heightDevice/100)
                ProgressView(value: quiz.currentProgression)
                    .padding(.horizontal)
                    .padding(.bottom, heightDevice/50)
            }
        }.background(Color(UIColor.secondarySystemBackground))
    }
}

struct QuizHeader_Previews: PreviewProvider {
    static var previews: some View {
        QuizHeader(
            quiz: Quiz(
                quickQuiz: false,
                difficulty: .easy,
                direction: .toRomaji,
                hiragana: true,
                katakana: false,
                kanaSection: .all,
                nbQuestions: 10.0),
            showScore: .constant(false),
            heightDevice: 830)
            .previewLayout(.sizeThatFits)
    }
}
