//
//  LessonsNavigationView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/03/2021.
//

import SwiftUI

struct LessonsNavigationView: View {
    @EnvironmentObject var modelData: ModelData
    var lessons: [LessonForList] {
        return modelData.lessons
    }
    
    @State var showReminder: Bool = false
    
    var body: some View {
        NavigationView {
            List(lessons) { lesson in
                NavigationLink(
                    destination: LessonInfoView(lesson: lesson),
                    label: {
                        LessonRow(lesson: lesson)
                    })
            }
            .navigationBarTitle("Lessons")
            .navigationBarItems(trailing: Button(action: {
                    hapticFeedback(style: .soft)
                    showReminder.toggle()
                },
                label: {
                    Label("Reminder", systemImage: "clock.arrow.circlepath")
                        .foregroundColor(Color.accentColor)
                        .font(.title3)
                        .padding(.bottom, 10.0)
                }).sheet(isPresented: $showReminder, content: {
                    ReminderView()
                })
            )
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    Image("Ema")
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
}

struct LessonsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsNavigationView()
    }
}
