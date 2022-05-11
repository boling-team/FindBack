//
//  BagLocationApp.swift
//  BagLocation
//
//  Created by Agus Budianto on 11/05/22.
//

import SwiftUI

@main
struct BagLocationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreenView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
