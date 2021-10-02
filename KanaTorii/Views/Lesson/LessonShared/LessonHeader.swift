//
//  LessonHeader.swift
//  Kana Torii
//
//  Created by Clément FLORET on 02/02/2021.
//

import SwiftUI

struct LessonHeader: View {
    @Environment(\.presentationMode) var presentation

    @StateObject var currentLesson: Lesson
    @Binding var lessonInfoMustClose: Bool
    
    var heightDevice: CGFloat

    var body: some View {
        HStack {
            Button(action: {
                currentLesson.lessonFinished()
                lessonInfoMustClose = true
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "multiply")
                    .font(.title)
                    .padding(.leading, 10)
            })
            VStack {
                if UIDevice.current.localizedModel == "iPad" {
                    Text("\(currentLesson.name) Part \(currentLesson.currentPartNumber) / \(currentLesson.totalParts)")
                        .padding(.top, heightDevice/100)
                } else {
                    Text("\(String(currentLesson.name.prefix(8))) Part \(currentLesson.currentPartNumber) / \(currentLesson.totalParts)")
                        .padding(.top, heightDevice/100)
                }

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
                kanas: ["あ", "い", "う", "え", "お"],
                romajis: ["a", "i", "u", "e", "o"]),
            lessonInfoMustClose: .constant(false),
            heightDevice: 600)
            .previewLayout(.sizeThatFits)
    }
}
