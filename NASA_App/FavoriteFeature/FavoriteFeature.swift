//
//  FavoriteFeature.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 02/02/25.
//

import ComposableArchitecture
import RequestLib
import SwiftData

@Reducer
struct FavoriteFeature {
    @ObservableState
    struct State {
        var isLoading = false
        var fetchDescriptor = FetchDescriptor<Favorites>()
        var favoritesList: [Favorites] = []
    }
    
    enum Action {
        case loadFavorites(ModelContext)
        case dataLoaded([Favorites])
    }
    
    func fetchData(_ modelContext: ModelContext, descriptor: FetchDescriptor<Favorites>) async -> [Favorites] {
        do {
            let favorites = try modelContext.fetch(descriptor)
            return favorites
        } catch {
            print("Failed to load Movie model.")
        }
        
        return []
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state, action in
            
            switch action {
            case .loadFavorites(let modelContext):
                state.isLoading = true
                do {
                    let favorites = try modelContext.fetch(state.fetchDescriptor)
                    return .send(.dataLoaded(favorites))
                } catch {
                    print("Failed to load Movie model.")
                }
                
                return .none
            case .dataLoaded(let result):
                state.isLoading = false
                state.favoritesList = result
                return .none
            }
        }
    }
}
