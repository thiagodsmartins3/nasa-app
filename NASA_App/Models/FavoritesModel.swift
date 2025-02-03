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
    var data: ApodPersistentModel
    
    init(data: ApodPersistentModel) {
        self.id = UUID()
        self.data = data
    }
}
