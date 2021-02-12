//
//  ListsView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/12/2020.
//

import SwiftUI

struct ListsView: View {
    @State var kanaTypePickerSelection: String = "hiragana"
    @State var showSettings = false
    private var kanaType: Kana.KanaType {
        if kanaTypePickerSelection == "hiragana" {
            return .hiragana
        } else {
            return .katakana
        }
    }
    private var navigationTitle: String {
        if kanaTypePickerSelection == "hiragana" {
            return "Hiragana charts"
        } else {
            return "Katakana charts"
        }
    }
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("Green"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("Green"))], for: .normal)
    }
    var body: some View {
        NavigationView(content: {
            VStack {
                Grid(type: kanaType)
                HStack {
                    Spacer()
                    Picker("Kana Type", selection: $kanaTypePickerSelection, content: {
                        Text("Hiragana").tag("hiragana")
                        Text("Katakana").tag("katakana")
                    })
                    .pickerStyle((SegmentedPickerStyle()))
                    .frame(maxWidth: 600, alignment: .center)
                    .padding(.top, 5.0)
                    .padding(.bottom, 10.0)
                    Spacer()
                }
            }
            .navigationBarTitle(navigationTitle, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showSettings.toggle()
            }, label: {
                Label("", systemImage: "gearshape")
                    .foregroundColor(Color("Green"))
                    .font(.title)
                    .padding(.bottom, 10.0)
                    .fullScreenCover(isPresented: $showSettings, content: {
                        SettingsView(
                            dislayStatisticsColorIsOn: true,
                            pickerDisplayMode: 1,
                            stepperNbQuestions: 10)
                    })
            }))
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListsView()
                .environmentObject(ModelData())
        }
    }
}
