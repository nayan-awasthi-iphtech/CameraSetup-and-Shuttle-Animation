//
//  ButtonAnimationApp.swift
//  ButtonAnimation
//
//  Created by iPHTech 30 on 07/09/26.
//

import SwiftUI
import CoreData

@main
struct ButtonAnimationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
