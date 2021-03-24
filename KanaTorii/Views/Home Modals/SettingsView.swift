//
//  SettingsView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 24/12/2020.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            VStack {
                SheetHeaderSettings(paddingLeading: 80)
                Spacer()
                SettingsForm()
                    .padding(.horizontal, 100)
                Spacer()
            }.background(Color(UIColor.secondarySystemBackground))
        } else {
            VStack {
                SheetHeaderSettings(paddingLeading: 20)
                Spacer()
                SettingsForm()
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
        }
    }
}
