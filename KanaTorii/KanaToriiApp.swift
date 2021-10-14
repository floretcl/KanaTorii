//
//  KanaToriiApp.swift
//  Shared
//
//  Created by Clément FLORET on 22/12/2020.
//

import SwiftUI
import StoreKit
import SwiftKeychainWrapper

@main
struct KanaToriiApp: App {
    @StateObject var storeManager = StoreManager()
    @StateObject var modelData = ModelData()
    let persistenceController = PersistenceController.shared

    let productIDs = [
        // 84 extra lesssons
        "fr.clementfloret.kanatorii.IAP.lessons"
    ]

    var body: some Scene {
        WindowGroup {
            ContentView(storeManager: storeManager)
                .environmentObject(storeManager)
                .environmentObject(modelData)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: {
                    if KeychainWrapper.standard.bool(forKey: productIDs[0]) == nil {
                        KeychainWrapper.standard.set(false, forKey: productIDs[0])
                    }
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts(productIDs: productIDs)
                })
        }
    }
}
