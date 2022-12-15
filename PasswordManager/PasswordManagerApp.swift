//
//  PasswordManagerApp.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import SwiftUI

@main
struct PasswordManagerApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MainView() .environment(\.managedObjectContext,
                                                  persistenceController.container.viewContext)
        }
    }
}
