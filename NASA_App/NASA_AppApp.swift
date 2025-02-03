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
    
    static let storeSearch = Store(initialState: SearchFeature.State()) {
        SearchFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(store: NASA_AppApp.store)
        }
        .modelContainer(for: Favorites.self)
    }
}
