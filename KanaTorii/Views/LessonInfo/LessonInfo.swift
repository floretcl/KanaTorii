//
//  LessonInfo.swift
//  Kana Torii
//
//  Created by Clément FLORET on 28/01/2021.
//

import SwiftUI

struct LessonInfo: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showActionSheet: Bool = true
    var lesson: LessonForList
    
    var body: some View {
        GeometryReader(content: { geometry in
            let heightDevice = geometry.size.height
            let widthDevice = geometry.size.width
            if colorScheme == .light {
                VStack {
                    LessonInfoText(lesson: lesson, heightDevice: heightDevice)
                    LessonInfoList(lesson: lesson, heightDevice: heightDevice)
                    ContinueNavLink(lesson: lesson, widthDevice: widthDevice, heightDevice: heightDevice)
                        .padding(.bottom, heightDevice/20)
                }
                .background(Color(UIColor.secondarySystemBackground))
            } else {
                VStack {
                    LessonInfoText(lesson: lesson, heightDevice: heightDevice)
                    LessonInfoList(lesson: lesson, heightDevice: heightDevice)
                    ContinueNavLink(lesson: lesson, widthDevice: widthDevice, heightDevice: heightDevice)
                        .padding(.bottom, heightDevice/20)
                }
            }
        })
        .navigationBarTitle("Lesson \(lesson.id + 1)", displayMode: .inline)
    }
}

struct LessonInfo_Previews: PreviewProvider {
    static var lessons = ModelData().lessons
    static var previews: some View {
        LessonInfo(lesson: lessons[0])
            .previewDevice("iPhone 11")
    }
}
