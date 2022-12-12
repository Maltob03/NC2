//
//  MainView.swift
//  NC2_PASS_MANAGER
//
//  Created by Matteo Altobello on 08/12/22.
//

import SwiftUI

struct MainView: View {
    let persistenceController = PersistenceController.shared
    var body: some View {
            TabView {
                LockerView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }

                ListView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem {
                        Label("Order", systemImage: "square.and.pencil")
                    }
            }
        }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

