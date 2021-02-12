//
//  LessonRow.swift
//  Kana Torii
//
//  Created by Clément FLORET on 27/01/2021.
//

import SwiftUI

struct LessonRow: View {
    var lesson: LessonForList
    
    var body: some View {
        HStack{
            ZStack {
                Circle()
                    .foregroundColor(.accentColor)
                    .frame(width: 45, height: 45, alignment: .center)
                Text("\(lesson.kanas[0])")
                    .font(.title2)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
            }
            VStack(alignment: .leading, spacing: 0, content: {
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
