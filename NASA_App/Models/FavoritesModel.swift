//
//  FavoritesModel.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 01/02/25.
//

import SwiftData
import Foundation

@Model
class Favorites {
    @Attribute(.unique) var id: UUID
    var favorite: [ApodModelElement] = []
    
    init(data: ApodModelElement) {
        self.id = UUID()
        favorite.insert(data, at: 0)
    }
}
