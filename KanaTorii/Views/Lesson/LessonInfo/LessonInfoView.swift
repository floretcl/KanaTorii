//
//  LessonInfoView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 28/01/2021.
//

import SwiftUI

struct LessonInfoView: View {
    @Environment(\.presentationMode) private var presentation
    @Environment(\.colorScheme) var colorScheme

    var lesson: LessonForList
    @State var lessonInfoMustClose: Bool = false

    var body: some View {
        VStack {
            if colorScheme == .light {
                LessonInfo(lesson: lesson, lessonInfoMustClose: $lessonInfoMustClose)
                .background(Color(UIColor.secondarySystemBackground))
            } else {
                LessonInfo(lesson: lesson, lessonInfoMustClose: $lessonInfoMustClose)
            }
        }
        .navigationBarTitle("Lesson \(lesson.id + 1)", displayMode: .inline)
        .onAppear(perform: {
            if lessonInfoMustClose {
                lessonInfoMustClose = false
                self.presentation.wrappedValue.dismiss()
            }
        })
    }
}

struct LessonInfoView_Previews: PreviewProvider {
    static var lessons = ModelData().lessons
    static var previews: some View {
        Group {
            LessonInfoView(lesson: lessons[0])
            LessonInfoView(lesson: lessons[0])
                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        }
    }
}
