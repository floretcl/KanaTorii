//
//  LessonsView.swift
//  Kana Torii (iOS)
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct LessonsView: View {
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            LessonsNavigationView()
        } else {
            LessonsNavigationView()
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsView()
            .environmentObject(StoreManager())
    }
}
