//
//  LessonHeader.swift
//  Kana Torii
//
//  Created by Clément FLORET on 02/02/2021.
//

import SwiftUI

struct LessonHeader: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var currentLesson: Lesson
    var heightDevice: CGFloat
    var body: some View {
        HStack {
            Button(action: {
                currentLesson.lessonFinished()
                presentation.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "multiply")
                    .font(.title)
                    .padding(.leading, 10)
            })
            VStack {
                Text("Part \(currentLesson.currentPartNumber) / \(currentLesson.totalParts)"  )
                    .padding(.top, heightDevice/100)
                ProgressView(value: currentLesson.currentProgression)
                    .padding(.horizontal)
                    .padding(.bottom, heightDevice/50)
            }
        }.background(Color(UIColor.secondarySystemBackground))
    }
}

struct LessonHeader_Previews: PreviewProvider {
    static var previews: some View {
        LessonHeader(
            currentLesson: Lesson(
                name: "Lesson 1 Hiragana a i u e o | Reading",
                mode: .reading,
                kanaType: "hiragana",
                kanas: ["あ","い","う","え","お"],
                romajis: ["a","i","u","e","o"]), heightDevice: 600)
            .previewLayout(.sizeThatFits)
    }
}
