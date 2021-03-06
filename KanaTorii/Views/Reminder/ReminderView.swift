//
//  ReminderView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 05/03/2021.
//

import SwiftUI

struct ReminderView: View {
    @ObservedObject var localNotification = LocalNotification()
    @State var showFootnote: Bool = false
    @State var date: Date = Date()
    @State var calendar = Calendar.current
    @State var selectedWeekDay: Int = 0
    var weekday = ["All","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var body: some View {
        
        NavigationView {
            Form(content: {
                Picker("Weekday", selection: $selectedWeekDay) {
                    ForEach(0..<weekday.count) {
                        Text(self.weekday[$0])
                    }
                }
                DatePicker("Hour: ", selection: $date, displayedComponents: [.hourAndMinute,])
                Button(action: {
                    hapticFeedback(style: .soft)
                    let hour = calendar.component(.hour, from: date)
                    let minute = calendar.component(.minute, from: date)
                    self.localNotification.sendNotification(title: "Kana Torii", subtitle: nil, body: "It's time to learn new kanas, がんばってください! (Ganbattekudasai!)", weekday: selectedWeekDay, hour: hour, minute: minute)
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
            
        
        
        
        //self.localNotification.sendNotification(title: "Kana Torii", subtitle: nil, body: "it's time to revise your kanas !!　がんばてください!　(Do your best!)", weekday: selectedWeekDay, hour: selectedHour, minute: selectedMinute)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
