//
//  KanaToriiApp.swift
//  Shared
//
//  Created by Clément FLORET on 22/12/2020.
//

import SwiftUI
import StoreKit

@main
struct KanaToriiApp: App {
    @StateObject var storeManager = StoreManager()
    @StateObject var modelData = ModelData()
    let persistenceController = PersistenceController.shared
    
    let productIDs = [
            // +100 lesssons
            "fr.clementfloret.kanatorii.IAP.lessons"
    ]
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storeManager)
                .environmentObject(modelData)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: {
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts(productIDs: productIDs)
                })
        }
    }
}
