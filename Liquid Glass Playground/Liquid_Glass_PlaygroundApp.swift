//
//  Liquid_Glass_PlaygroundApp.swift
//  Liquid Glass Playground
//
//  Created by Zac Garbos on 2025-06-21.
//

import SwiftUI
import SwiftData

@main
struct Liquid_Glass_PlaygroundApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
