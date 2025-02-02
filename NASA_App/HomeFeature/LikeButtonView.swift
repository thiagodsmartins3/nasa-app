//
//  LikeButtonView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 01/02/25.
//

import SwiftUI

struct LikeButtonView: View {
    @Binding var isLiked: Bool
    
    var body: some View {
        Button(action: {
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
            Text(isLiked ? "Liked" : "Like")
        }
    }
}
