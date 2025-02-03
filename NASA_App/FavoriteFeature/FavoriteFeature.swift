//
//  FavoriteFeature.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 02/02/25.
//

import ComposableArchitecture

import ComposableArchitecture
import RequestLib

@Reducer
struct FavoriteFeature {
    @ObservableState
    struct State {
        var isLoading = false
        var apodData: ApodModelElement? = nil
    }
    
    enum Action {
        case requestData(String)
        case dataLoaded(ApodModelElement)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state, action in
            
            switch action {
            case .requestData(let data):
                state.isLoading = true
                return .run { send in
                    Task {
                        do {
                            let data = try await Request.request(
                                url: "https://api.nasa.gov/planetary/apod",
                                parameters: ["api_key": "tXmVmbfNXhgA5E4vlxFWf6iOvhakt8vc4eOvbJeE",
                                             "date": data],
                                responseModel: ApodModelElement.self
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
