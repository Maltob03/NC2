//
//  NC2_PASS_MANAGERApp.swift
//  NC2_PASS_MANAGER
//
//  Created by Matteo Altobello on 08/12/22.
//

import SwiftUI

@main
struct NC2_PASS_MANAGERApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MainView() .environment(\.managedObjectContext,
                                        persistenceController.container.viewContext)
        }
    }
}
