//
//  SwiftCafeApp.swift
//  SwiftCafe
//
//  Created by Jason Tse on 23/6/2023.
//

import SwiftUI

@main
struct SwiftCafeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
