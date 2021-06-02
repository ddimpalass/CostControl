//
//  SpendApp.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

@main
struct SpendApp: App {
    let isFirstLaunch = UserDefaults.isFirstLaunch()
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                FirstLaunchView()
            } else {
                PeriodListView()
            }
        }
    }
}
