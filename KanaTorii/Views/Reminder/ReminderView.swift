//
//  ReminderView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 05/03/2021.
//

import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var modelData: ModelData
    @ObservedObject var localNotification = LocalNotification()
    @State var showFootnote: Bool = false
    @State var date: Date = Date()
    @State var calendar = Calendar.current
    @State var selectedWeekDay: Int = 0
    var weekdays: [Weekday] {
        return modelData.weekdays
    }

    var body: some View {
        NavigationView {
            Form(content: {
                Picker("Weekday", selection: $selectedWeekDay) {
                    ForEach(0..<weekdays.count) {
                        Text(self.weekdays[$0].name)
                    }
                }
                DatePicker("Hour:", selection: $date, displayedComponents: [.hourAndMinute ])
                Button(action: {
                    hapticFeedback(style: .soft)
                    let hour = calendar.component(.hour, from: date)
                    let minute = calendar.component(.minute, from: date)
                    self.localNotification.sendNotification(
                        title: "Kana Torii",
                        subtitle: nil,
                        body: "It's time to learn new kanas, がんばって! (Cheer up!)",
                        weekday: selectedWeekDay,
                        hour: hour,
                        minute: minute)
                    showFootnote.toggle()
                }, label: {
                    Text("Validate")
                })
                if showFootnote {
                    Text("Notification will arrive on time")
                        .font(.footnote)
                }
            })
            .navigationTitle("Reminder")
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
            .environmentObject(ModelData())
    }
}
