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
    @Environment(\.modelContext) var modelContext
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack {
            List(store.state.apodData) {
                data in
                Section {
                    ListRowView(item: data, likedRow: $isLiked)
                        .id(data.id)
                        .listRowBackground(
                            isLiked ?
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 2) : nil
                        )
                }

                
                if store.state.isLoading {
                    ProgressView()
                        .padding()
                }
                
                if data == store.state.apodData.last {
                    Color.clear
                        .onAppear {
                            store.send(.loadMoreData)
                        }
                }
            }
            .listRowSpacing(10)
        }
        .onAppear() {
            store.send(.onAppear)
        }
    }
    
    func saveToFavorites() {
        let save = Favorites(date: "2024-10-10")
        modelContext.insert(save)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

#Preview {
  HomeView(
    store: Store(initialState: HomeFeature.State()) {
      HomeFeature()
    }
  )
}
