//
//  HomeView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 30/01/25.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

struct HomeView: View {
    let store: StoreOf<HomeFeature>
    @Environment(\.modelContext) private var modelContext
    @State private var isLiked: Bool = false
    @State private var showSearchButton: Bool = true
    @State private var showFavoritesButton: Bool = true
    @State private var presentSearchView: Bool = false
    @State private var presentFavoritesView: Bool = false
    @State private var isFavoriteEmpty: Bool = true
    @Query(sort: \Favorites.id, order: .reverse) var favorites: [Favorites]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text("NASA APP")
                    .frame(width: UIScreen.main.bounds.size.width)
                    .background(Color.blue)
                    .padding(.bottom)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                
                List(store.state.apodData) {
                    data in
                    Section {
                        ListRowView(item: data, likedRow: $isLiked)
                    }

                    if isLiked {
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
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.5).onEnded({ _ in
                        withAnimation {
                            showSearchButton.toggle()
                            showFavoritesButton.toggle()
                        }
                    })
                )
            }
            .onAppear() {
                store.send(.onAppear)
            }
            
            VStack {
                Button {
                    presentSearchView.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(.orange)
                        .clipShape(Circle())
                        .shadow(radius: 5, x: 0, y: 3)
                }
                .padding()
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .opacity(showSearchButton ? 1 : 0)
                .fullScreenCover(isPresented: $presentSearchView) {
                    SearchView(isPresented: $presentSearchView, store: NASA_AppApp.storeSearch)
                }
                
                Button {
                    presentFavoritesView.toggle()
//                    let fetchDescriptor = FetchDescriptor<Favorites>()
//
//                    do {
//                        let favorites = try modelContext.fetch(fetchDescriptor)
//                        
//                        for dt in favorites {
//                        
//                        }
//                        
//                        if favorites.isEmpty {
//                            isFavoriteEmpty = true
//                        } else {
//                            isFavoriteEmpty = false
//                        }
//                        
//                    } catch {
//                        print("Failed to load Movie model.")
//                    }
                } label: {
                    Image(systemName: "heart.circle")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(isLiked ? .gray : .red)
                        .clipShape(Circle())
                        .shadow(radius: 5, x: 0, y: 3)
                }
                .padding()
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .opacity(showFavoritesButton ? 1 : 0)
                .fullScreenCover(isPresented: $presentFavoritesView) {
                    FavoriteView(store: NASA_AppApp.storeFavorites, isPresented: $presentFavoritesView)
                }
            }
        }
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
