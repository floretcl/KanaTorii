//
//  LessonInfoList.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/01/2021.
//

import SwiftUI

struct LessonInfoList: View {
    var lesson: LessonForList
    var heightDevice: CGFloat

    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            List {
                ForEach(0..<lesson.kanas.count) { index in
                    let kana = lesson.kanas[index]
                    let romaji = lesson.romaji[index]
                    Text("\(kana)    :    \(romaji)")
                        .font(.system(size: heightDevice/45))
                        .padding(.vertical, 20)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.horizontal, 100)
        } else {
            List {
                ForEach(0..<lesson.kanas.count) { index in
                    let kana = lesson.kanas[index]
                    let romaji = lesson.romaji[index]
                    Text("\(kana)    :    \(romaji)")
                        .font(.system(size: heightDevice/35))
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct LessonInfoList_Previews: PreviewProvider {
    static var lessons = ModelData().lessons
    static var previews: some View {
        LessonInfoList(lesson: lessons[0], heightDevice: 600)
            .previewLayout(.sizeThatFits)
    }
}
