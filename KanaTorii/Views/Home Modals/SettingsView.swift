//
//  SettingsView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 24/12/2020.
//

import SwiftUI

struct SettingsView: View {
    @State var dislayStatisticsColorIsOn: Bool
    @State var pickerDisplayMode: Int
    @State var stepperNbQuestions: Double
    var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            VStack {
                SheetHeader(title: "Settings", systemImage: "gearshape", paddingLeading: 20)
                Spacer()
                Form {
                    Section(header: Text("DISPLAY MODE")) {
                        Picker("Display mode", selection: $pickerDisplayMode) {
                            Text("Default").tag(1)
                            Text("Light").tag(2)
                            Text("Dark").tag(3)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("CHARACTER CHARTS")) {
                        Toggle("Statistics colors in tables", isOn: $dislayStatisticsColorIsOn)
                    }
                    Section(header: Text("QUICK QUIZ")) {
                        VStack {
                            Text("Number of questions: \(Int(stepperNbQuestions))")
                            Slider(
                                value: $stepperNbQuestions,
                                in: 5...100,
                                step: 5,
                                minimumValueLabel: Text("5"),
                                maximumValueLabel: Text("100"))
                                {
                                Text("Number of questions: \(Int(stepperNbQuestions))")
                                }
                        }
                    }
                    Section(header: Text("DATA")) {
                        HStack {
                            Text("Reset all data")
                            Spacer()
                            Button("Reset") {
                                // Reset data
                            }.padding(.all, 12.0)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(8)
                        }
                    }
                    Section(header: Text("ABOUT"), footer: Text("Kana Torii © 2020 Clément Floret")) {
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
                .padding(.horizontal, 100)
                .background(Color(.secondarySystemBackground))
                Spacer()
            }
        } else {
            VStack {
                SheetHeader(title: "Settings", systemImage: "gearshape", paddingLeading: 20)
                Spacer()
                Form {
                    Section(header: Text("DISPLAY MODE")) {
                        Picker("Display mode", selection: $pickerDisplayMode) {
                            Text("Default").tag(1)
                            Text("Light").tag(2)
                            Text("Dark").tag(3)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("CHARACTER CHARTS")) {
                        Toggle("Statistics colors in tables", isOn: $dislayStatisticsColorIsOn)
                    }
                    Section(header: Text("QUICK QUIZ")) {
                        VStack {
                            Text("Number of questions: \(Int(stepperNbQuestions))")
                            Slider(
                                value: $stepperNbQuestions,
                                in: 5...100,
                                step: 5,
                                minimumValueLabel: Text("5"),
                                maximumValueLabel: Text("100"))
                                {
                                Text("Number of questions: \(Int(stepperNbQuestions))")
                                }
                        }
                    }
                    Section(header: Text("DATA")) {
                        HStack {
                            Text("Reset all data")
                            Spacer()
                            Button("Reset") {
                                // Reset data
                            }.padding(.all, 12.0)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(8)
                        }
                    }
                    Section(header: Text("ABOUT"), footer: Text("Kana Torii © 2020 Clément Floret")) {
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
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(dislayStatisticsColorIsOn: true, pickerDisplayMode: 1, stepperNbQuestions: 10)
        }
    }
}
