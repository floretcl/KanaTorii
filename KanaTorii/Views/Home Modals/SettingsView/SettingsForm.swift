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
    @ObservedObject var userSettings = UserSettings()
    
    //App Version
    var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    @State var showAlertResetData: Bool = false
    let minimumValue: String = "10"
    let maximumValue: String = "40"
    
    var body: some View {
        Form {
            Section(header: Text("CHARACTER CHARTS")) {
                Toggle("Statistics colors in tables", isOn: $userSettings.colorsInTables)
                HStack {
                    Text("Primary").foregroundColor(.primary)
                    Text("Red").foregroundColor(.red)
                    Text("Orange").foregroundColor(.orange)
                    Text("Yellow").foregroundColor(.yellow)
                    Text("Green").foregroundColor(.green)
                }
            }
            Section(header: Text("QUICK QUIZ")) {
                VStack {
                    Text("Number of questions: \(Int(userSettings.quickQuizNbQuestions))")
                    Slider(
                        value: $userSettings.quickQuizNbQuestions,
                        in: 10...40,
                        step: 5,
                        onEditingChanged: {_ in
                            hapticFeedback(style: .soft)
                        },
                        minimumValueLabel: Text(minimumValue),
                        maximumValueLabel: Text(maximumValue))
                        {
                        Text("Number of questions: \(Int(userSettings.quickQuizNbQuestions))")
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
            Section(header: Text("ABOUT"), footer: Text("Kana Torii © 2021 Clément Floret")) {
                HStack {
                    Text("Version")
                    if let version = appVersion {
                        Text(version)
                    }
                }
                Link(destination: URL(string: "https://floretcl.github.io/en/kanatorii.html")!, label: {
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
            //let nsError = error as NSError
            //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct SettingsForm_Previews: PreviewProvider {
    static var previews: some View {
        SettingsForm()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
