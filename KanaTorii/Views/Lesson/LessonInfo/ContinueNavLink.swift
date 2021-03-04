//
//  ContinueNavLink.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct ContinueNavLink: View {
    var lesson: LessonForList
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    
    var body: some View {
        if lesson.type == "Reading" {
            VStack {
                NavigationLink(
                    destination: LessonMemoReading(currentLesson: Lesson(
                            name: "\(lesson.title) | \(lesson.type)",
                            mode: .reading,
                            kanaType: lesson.kanaTypeString,
                            kanas: lesson.kanas,
                            romajis: lesson.romaji)),
                    label: {
                        ButtonLabel(widthDevice: widthDevice, heightDevice: heightDevice, textSize: heightDevice/40, text: "Continue")
                    }
                )
            }
        } else {
            VStack {
                NavigationLink(
                    destination: LessonMemoWriting(currentLesson: Lesson(
                            name: "\(lesson.title) | \(lesson.type)",
                            mode: .writing,
                            kanaType: lesson.kanaTypeString,
                            kanas: lesson.kanas,
                            romajis: lesson.romaji)),
                    label: {
                        ButtonLabel(widthDevice: widthDevice, heightDevice: heightDevice, textSize: heightDevice/40, text: "Continue")
                    }
                )
            }
        }
    }
}

struct ContinueNavLink_Previews: PreviewProvider {
    static var lessons = ModelData().lessons
    static var previews: some View {
        ContinueNavLink(lesson: lessons[0], widthDevice: 300, heightDevice: 600)
            .previewLayout(.sizeThatFits)
    }
}
