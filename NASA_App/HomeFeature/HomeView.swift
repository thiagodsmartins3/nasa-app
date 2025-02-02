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
    @State private var showButton: Bool = true
    @State private var presentSearchView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text("NASA")
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
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.5).onEnded({ _ in
                        withAnimation {
                            showButton.toggle()
                        }
                    })
                )
            }
            .onAppear() {
                store.send(.onAppear)
            }
            
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
            .opacity(showButton ? 1 : 0)
            .fullScreenCover(isPresented: $presentSearchView) {
                SearchView(isPresented: $presentSearchView, store: NASA_AppApp.storeSearch)
            }
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
