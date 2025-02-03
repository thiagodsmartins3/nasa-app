//
//  FavoriteListView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 03/02/25.
//

import SwiftUI
import RequestLib

struct FavoritesListView: View {
    var item: Favorites
    @State private var isLiked: Bool = false
    @Binding var likedRow: Bool
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(item.data.title ?? "")
                Text(item.data.date ?? "")
                Text(item.data.explanation ?? "")
                AsyncImage(url: URL(string: item.data.url ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }

}
