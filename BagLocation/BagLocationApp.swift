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
    @AppStorage("FirstTimeUser") var firstTimeUser: Bool = true
//    @State var firstTimeUser: Bool = true
    
    var body: some Scene {
            WindowGroup {
                HomeScreenView()
                    .fullScreenCover(isPresented: $firstTimeUser) {
                        OnboardingMainScreen()
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(ListRefreshID())
            }
        }
    }

