//
//  LessonInfoText.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct LessonInfoText: View {
    var lesson: LessonForList
    var heightDevice: CGFloat
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            VStack(alignment: .leading, spacing: 2, content: {
                Text(lesson.text)
                    .font(.system(size: heightDevice/50))
            })
            .padding(.top, heightDevice/20)
            .padding(.horizontal, 100)
        } else {
            VStack(alignment: .leading, spacing: 2, content: {
                Text(lesson.text)
                    .font(.system(size: heightDevice/38))
            })
            .padding(.all, 10)
            .padding(.top, heightDevice/20)
            .padding(.horizontal, 20)
        }
    }
}

struct LessonInfoText_Previews: PreviewProvider {
    static var lessons = ModelData().lessons
    static var previews: some View {
        Group {
            LessonInfoText(lesson: lessons[0], heightDevice: 600)
                .previewLayout(.sizeThatFits)
        }
    }
}
