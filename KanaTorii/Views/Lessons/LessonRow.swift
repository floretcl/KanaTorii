//
//  LessonRow.swift
//  Kana Torii
//
//  Created by Clément FLORET on 27/01/2021.
//

import SwiftUI

struct LessonRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatLesson.name, ascending: true)],
        animation: .default) var statLesson: FetchedResults<StatLesson>
    var lesson: LessonForList
    var color: Color {
        var done: Bool = false
        for stat in statLesson {
            if stat.name == "\(lesson.title) | \(lesson.type)" {
                if stat.done {
                    done = true
                }
            }
        }
        return done ? .green : .accentColor
    }
    
    var body: some View {
        HStack{
            ZStack {
                Circle()
                    .foregroundColor(color)
                    .frame(width: 45, height: 45, alignment: .center)
                Text("\(lesson.kanas[0])")
                    .font(.title2)
                    .shadow(color: Color.black, radius: 2, x: 1.0, y: 2.0)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
            }
            VStack(alignment: .leading, spacing: nil, content: {
                Text(lesson.title)
                    .font(.subheadline)
                Text(lesson.type)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            })
            Spacer()
        }
    }
}

struct LessonRow_Previews: PreviewProvider {
    static var lessons = ModelData().lessons
    static var previews: some View {
        LessonRow(lesson: lessons[0])
            .previewLayout(.sizeThatFits)
        LessonRow(lesson: lessons[100])
            .previewLayout(.sizeThatFits)
    }
}
