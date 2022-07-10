//
//  FactzzzApp.swift
//  Factzzz
//
//  Created by Luke Hendriks on 10/07/2022.
//

import SwiftUI

@main
struct FactzzzApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
