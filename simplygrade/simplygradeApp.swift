//
//  simplygradeApp.swift
//  simplygrade
//
//  Created by Development on 15.10.20.
//

import SwiftUI

@main
struct simplygradeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
