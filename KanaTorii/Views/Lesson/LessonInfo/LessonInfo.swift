//
//  LessonInfo.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/03/2021.
//

import SwiftUI

struct LessonInfo: View {
    var lesson: LessonForList
    @State var lessonAlreadyStart: Bool = false
    
    var body: some View {
        GeometryReader(content: { geometry in
            let heightDevice = geometry.size.height
            let widthDevice = geometry.size.width
            VStack {
                LessonInfoText(lesson: lesson, heightDevice: heightDevice)
                LessonInfoList(lesson: lesson, heightDevice: heightDevice)
                ContinueNavLink(lesson: lesson, widthDevice: widthDevice, heightDevice: heightDevice)
                    .padding(.bottom, heightDevice/20)
                    .onTapGesture(perform: {
                        lessonAlreadyStart.toggle()
                    })
            }
        })
    }
}

struct LessonInfo_Previews: PreviewProvider {
    static var lessons = ModelData().lessons
    static var previews: some View {
        LessonInfo(lesson: lessons[0])
    }
}
