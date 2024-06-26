//
//  SettingsForm.swift
//  KanaTorii
//
//  Created by Clément FLORET on 19/03/2021.
//

import SwiftUI

struct SettingsForm: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatLesson.name, ascending: true)],
        animation: .default) var statLesson: FetchedResults<StatLesson>

    // User Defaults
    @AppStorage var colorsInTables: Bool
    @AppStorage var quickQuizNbQuestions: Double

    @ObservedObject var localNotification = LocalNotification()

    // App Version
    var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    @State var showAlertStopNotifications: Bool = false
    @State var showAlertResetData: Bool = false
    let minimumValue: String = "10"
    let maximumValue: String = "40"

    var body: some View {
        Form {
            Section(header: Text("CHARACTER CHARTS")) {
                Toggle("Statistics colors in tables", isOn: $colorsInTables)
                HStack {
                    Text("Primary")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text("Red")
                        .font(.subheadline)
                        .foregroundColor(.red)
                    Text("Orange")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                    Text("Yellow")
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                    Text("Green")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
            Section(header: Text("QUICK QUIZ")) {
                VStack {
                    Text("Number of questions: \(Int(quickQuizNbQuestions))")
                    Slider(
                        value: $quickQuizNbQuestions,
                        in: 10...40,
                        step: 5,
                        onEditingChanged: {_ in
                            hapticFeedback(style: .soft)
                        },
                        minimumValueLabel: Text(minimumValue),
                        maximumValueLabel: Text(maximumValue)) {
                        Text("Number of questions: \(Int(quickQuizNbQuestions))")
                    }
                }
            }
            Section(header: Text("DATA")) {
                HStack {
                    Text("Reset all datas")
                    Spacer()
                    Button("Reset") {
                        showAlertResetData.toggle()
                        hapticFeedback(style: .medium)
                    }.padding(.all, 12.0)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
                    .alert(isPresented: $showAlertResetData, content: {
                        Alert(
                            title: Text("Reset all datas"),
                            message: Text("Progress of lessons and statistics will be deleted"),
                            primaryButton: .destructive(Text("Delete"),
                                                        action: {
                                                            deleteAllItems()
                                                        }),
                            secondaryButton: .cancel()
                        )
                    })
                }
            }
            Section(header: Text("NOTIFICATIONS")) {
                HStack {
                    Text("Stop current notifications")
                    Spacer()
                    Button("Stop") {
                        showAlertStopNotifications.toggle()
                        hapticFeedback(style: .medium)
                    }.padding(.all, 12.0)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
                    .alert(isPresented: $showAlertStopNotifications, content: {
                        Alert(
                            title: Text("Stop current notifications"),
                            message: Text("Scheduled notifications will no longer be displayed"),
                            primaryButton: .destructive(Text("Stop"),
                                                        action: {
                                                            self.localNotification.stopNotification()
                                                        }),
                            secondaryButton: .cancel()
                        )
                    })
                }
            }

            Section(header: Text("ABOUT"), footer: Text("Kana Torii © 2021 Clément Floret")) {
                HStack {
                    Text("Version")
                    if let version = appVersion {
                        Text(version)
                    }
                }
                Link(destination: URL(string: "https://www.kanatorii.com")!, label: {
                    Label("Support website", systemImage: "network")
                })
                Link(destination: URL(string: "https://twitter.com/FloretClement")!, label: {
                    Label("Twitter", systemImage: "message")
                })
            }
        }
    }

    private func deleteAllItems() {
        statKana.forEach { stat in
            viewContext.delete(stat)
        }
        statLesson.forEach { stat in
            viewContext.delete(stat)
        }
        do {
            try viewContext.save()
        } catch {
            print(error)
            // let nsError = error as NSError
            // fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct SettingsForm_Previews: PreviewProvider {
    static var previews: some View {
        SettingsForm(colorsInTables: .init(wrappedValue: true, "colors-in-tables"), quickQuizNbQuestions: .init(wrappedValue: 10.0, "quick-quiz-nb-questions"))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
