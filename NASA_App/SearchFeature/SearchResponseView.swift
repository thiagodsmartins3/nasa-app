//
//  SearchResponseView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 02/02/25.
//

import SwiftUI

struct SearchResponseView: View {
    var item: ApodModelElement
    @State private var isLiked: Bool = false
    @Binding var liked: Bool
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 20) {
                    LikeButtonView(isLiked: $isLiked)
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
                .padding([.leading, .trailing], 10)
                .cornerRadius(15)
                .gesture(
                    TapGesture(count: 2).onEnded {
                        Task {
                            try? await Task.sleep(nanoseconds: 200_000_000)
                            self.isLiked.toggle()
                            liked = isLiked
                        }
                    }
                )
            }
        }
    }

}
