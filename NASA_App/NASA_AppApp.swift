//
//  NASA_AppApp.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 30/01/25.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct NASA_AppApp: App {
    static let store = Store(initialState: HomeFeature.State()) {
        HomeFeature()
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Favorites.self,
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
            HomeView(store: NASA_AppApp.store)
        }
        .modelContainer(sharedModelContainer)
    }
}
