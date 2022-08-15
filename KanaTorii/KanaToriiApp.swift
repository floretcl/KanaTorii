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
//    let productIDs = [
//        // 84 extra lesssons
//        "fr.clementfloret.kanatorii.IAP.lessons"
//    ]
    
    
    @StateObject var modelData = ModelData()
    let persistenceController = PersistenceController.shared

    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .onAppear(perform: {
//                    SKPaymentQueue.default().add(storeManager)
//                    storeManager.getProducts(productIDs: productIDs)
//                })
        }
    }
}
