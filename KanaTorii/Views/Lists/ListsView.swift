//
//  ListsView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 30/12/2020.
//

import SwiftUI

struct ListsView: View {
    @State var pickerSelection: String = "hiragana"
    @State var showSettings = false
    private var kanaType: Kana.KanaType {
        if pickerSelection == "hiragana" {
            return .hiragana
        } else {
            return .katakana
        }
    }
    private var navigationTitle: String {
        if pickerSelection == "hiragana" {
            return "Hiragana charts"
        } else {
            return "Katakana charts"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            NavigationView(content: {
                VStack {
                    Grid(type: kanaType, heightDevice: heightDevice, widthDevice: widthDevice)
                    HStack {
                        Spacer()
                        GreenSegmentedControl(pickerSelection: $pickerSelection)
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
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListsView()
                .environmentObject(ModelData())
        }
    }
}
