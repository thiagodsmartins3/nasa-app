//
//  HomeFeature.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 30/01/25.
//

import ComposableArchitecture

@Reducer
struct HomeFeature {
    @ObservableState
    struct State {
        var isLoading = false
        var apodData: ApodModel = []
    }
    
    enum Action {
        case requestData
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state, action in
            
            switch action {
            case .requestData:
                return .none
            }
        }
    }
}
