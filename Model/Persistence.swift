//
//  Persistence.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import Foundation

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "Accounts")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
