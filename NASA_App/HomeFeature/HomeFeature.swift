//
//  HomeFeature.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 30/01/25.
//

import ComposableArchitecture
import RequestLib

@Reducer
struct HomeFeature {
    @ObservableState
    struct State {
        var isLoading = false
        var apodData: ApodModel = []
    }
    
    enum Action {
        case onAppear
        case dataLoaded(ApodModel)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state, action in
            
            switch action {
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    Task {
                        do {
                            let data = try await Request.request(
                                url: "https://api.nasa.gov/planetary/apod",
                                parameters: ["api_key": "tXmVmbfNXhgA5E4vlxFWf6iOvhakt8vc4eOvbJeE",
                                             "count": 3],
                                responseModel: ApodModel.self
                            )!
                            await send(.dataLoaded(data))
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }
            case .dataLoaded(let result):
                state.isLoading = false
                state.apodData = result
                return .none
            }
        }
    }
}
