//
//  LessonsView.swift
//  Kana Torii (iOS)
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct LessonsView: View {
    @StateObject var storeManager: StoreManager

    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            LessonsNavigationView(storeManager: storeManager)
        } else {
            LessonsNavigationView(storeManager: storeManager)
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsView(storeManager: StoreManager())
    }
}
