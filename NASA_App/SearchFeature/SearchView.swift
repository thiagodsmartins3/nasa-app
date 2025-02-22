//
//  SearchView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 02/02/25.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    @State private var inputText: String = ""
    @State private var isLiked = false
    @Binding var isPresented: Bool
    let store: StoreOf<SearchFeature>
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
              Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 24, height: 24)
                TextField("Search for a date", text: $inputText)
                    .onSubmit {
                        store.send(.requestData(inputText))
                    }
            }
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            
            
            if store.state.isLoading {
                ProgressView()
                    .padding()
            }
            
            if let result = store.state.apodData {
                SearchResponseView(item: result, liked: $isLiked)
            } else {
                Image("nasa")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2,
                           height: UIScreen.main.bounds.height / 2,
                           alignment: .center)
                    .padding([.leading, .trailing], 10)
            }
            Spacer()
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
