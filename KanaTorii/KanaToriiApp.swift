//
//  KanaToriiApp.swift
//  Shared
//
//  Created by Clément FLORET on 22/12/2020.
//

import SwiftUI


@main
struct KanaToriiApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView(tabViewSelectedItem: 1)
                .environmentObject(ModelData())
        }
    }
}
