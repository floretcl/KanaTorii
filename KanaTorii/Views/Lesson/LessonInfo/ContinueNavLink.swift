//
//  ContinueNavLink.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct ContinueNavLink: View {
    @Environment(\.managedObjectContext) private var viewContext
    var lesson: LessonForList
    var widthDevice: CGFloat
    var heightDevice: CGFloat
    
    var body: some View {
        if lesson.type == "Reading" || lesson.type == "Lecture" {
            VStack {
                NavigationLink(
                    destination: LessonMemoReading(currentLesson: Lesson(
                            name: "\(lesson.title) | \(lesson.type)",
                            mode: .reading,
                            kanaType: lesson.kanaTypeString,
                            kanas: lesson.kanas,
                            romajis: lesson.romaji))
                        .environment(\.managedObjectContext, self.viewContext),
                    label: {
                        Text("Continue")
                            .font(.system(size: heightDevice/40))
                            .padding(.horizontal, widthDevice/8)
                            .padding(.vertical, heightDevice/50)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .clipShape(Capsule())
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
                            romajis: lesson.romaji))
                        .environment(\.managedObjectContext, self.viewContext),
                    label: {
                        Text("Continue")
                            .font(.system(size: heightDevice/40))
                            .padding(.horizontal, widthDevice/8)
                            .padding(.vertical, heightDevice/50)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .clipShape(Capsule())
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
