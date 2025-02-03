//
//  ApodPersistentModel.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 02/02/25.
//

import Foundation
import SwiftData

@Model
class ApodPersistentModel {
    var id = UUID()
    var copyright: String?
    var date: String?
    var explanation: String?
    var hdurl: String?
    var mediaType: String?
    var serviceVersion: String?
    var title: String?
    var url: String?
    var isLiked: Bool? = false
    
    init(id: UUID = UUID(), copyright: String?, date: String?, explanation: String?, hdurl: String?, mediaType: String?, serviceVersion: String?, title: String?, url: String?, isLiked: Bool? = nil) {
        self.id = id
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.serviceVersion = serviceVersion
        self.title = title
        self.url = url
        self.isLiked = isLiked
    }
}
