//
//  LessonsView.swift
//  Kana Torii (iOS)
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct LessonsView: View {
    @EnvironmentObject var modelData: ModelData
    @State var showReminder: Bool = false
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsView()
            .environmentObject(ModelData())
    }
}
