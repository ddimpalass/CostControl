//
//  SpendApp.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

@main
struct SpendApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PeriodListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
