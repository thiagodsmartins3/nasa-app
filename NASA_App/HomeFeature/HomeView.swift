//
//  HomeView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 30/01/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        VStack {
            List(store.state.apodData) {
                data in
                ListRowView(item: data)
            }
        }
        .onAppear() {
            store.send(.onAppear)
        }
    }
}

#Preview {
  HomeView(
    store: Store(initialState: HomeFeature.State()) {
      HomeFeature()
    }
  )
}
