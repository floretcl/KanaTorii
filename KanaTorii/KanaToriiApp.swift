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
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
