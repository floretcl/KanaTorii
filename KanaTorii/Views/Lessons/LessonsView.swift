//
//  LessonsView.swift
//  Kana Torii (iOS)
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct LessonsView: View {
    @EnvironmentObject var modelData: ModelData
    var lessons: [LessonForList] {
        return modelData.lessons
    }
    
    var body: some View {
        NavigationView {
            List(lessons) { lesson in
                NavigationLink(
                    destination: LessonInfoView(lesson: lesson),
                    label: {
                        LessonRow(lesson: lesson)
                    })
            }
            .navigationTitle("Lessons")
            .navigationBarItems(trailing: Button(action: {
                    //
                }, label: {
                    Label("", systemImage: "clock.arrow.circlepath")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                        .padding(.bottom, 10.0)
                })
            )
            VStack {
                Image("ema")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .clipShape(Circle())
                Text("Start a lesson right now by clicking on 'lessons' at the top left")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.bottom, 100)
            }
        }
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsView()
            .previewDevice("iPhone 11")
            .environmentObject(ModelData())
    }
}
