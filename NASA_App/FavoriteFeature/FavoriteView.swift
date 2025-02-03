//
//  FavoriteView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 02/02/25.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

struct FavoriteView: View {
    let store: StoreOf<FavoriteFeature>
    @Environment(\.modelContext) private var modelContext
    @State private var isLiked: Bool = false
    @State private var isFavoriteEmpty: Bool = true
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text("Favorites")
                    .frame(width: UIScreen.main.bounds.size.width)
                    .background(Color.blue)
                    .padding(.bottom)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                
                List(store.state.favoritesList) {
                    data in
                    Section {
                        FavoritesListView(item: data, likedRow: $isLiked)
                    }
                }
                .listRowSpacing(10)
            }
            .onAppear() {
                store.send(.loadFavorites(modelContext))
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.height > 100 {
                            isPresented = false
                        }
                    }
            )
        }
    }
}
