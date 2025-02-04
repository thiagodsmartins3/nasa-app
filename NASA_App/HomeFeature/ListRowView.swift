//
//  ListRowView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 31/01/25.
//

import SwiftUI
import RequestLib
import Foundation
struct ListRowView: View {
    var item: ApodModelElement
    @State private var isLiked: Bool = false
    @Binding var likedRow: Bool
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                LikeButtonView(isLiked: $isLiked, action: {
                    liked in
                    
                    if liked {
                        modelContext.insert(Favorites(data: ApodPersistentModel(copyright: item.copyright ?? "", date: item.date, explanation: item.explanation, hdurl: item.hdurl ?? "", mediaType: item.mediaType ?? "", serviceVersion: item.serviceVersion ?? "", title: item.title ?? "", url: item.url ?? "")))
                        print("Inserted")
                    } else {
                        try! modelContext.delete(model: Favorites.self, where: #Predicate {
                            $0.data.title ?? "" == item.title ?? ""
                        })
                        print("Removed")
                    }
                })
                    .foregroundColor(.red)
                Text(item.title ?? "")
                Text(item.date ?? "")
                Text(item.explanation ?? "")
                AsyncImage(url: URL(string: item.url ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
                } placeholder: {
                    ProgressView()
                }
            }
//            .gesture(
//                TapGesture(count: 2).onEnded {
//                    Task {
//                        try? await Task.sleep(nanoseconds: 200_000_000)
//                        self.isLiked.toggle()
//                        likedRow = isLiked
//                    }
//                }
//            )
        }
    }

}
