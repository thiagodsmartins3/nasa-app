//
//  LikeButtonView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 01/02/25.
//

import SwiftUI

struct LikeButtonView: View {
    @Binding var isLiked: Bool
    var action: (Bool) -> Void
    
    var body: some View {
        Button(action: {
            isLiked.toggle()
            action(isLiked)
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
            Text(isLiked ? "Liked" : "Like")
        }
    }
}
