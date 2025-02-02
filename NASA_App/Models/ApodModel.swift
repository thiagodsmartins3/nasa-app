//
//  ApodModel.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 30/01/25.
//

import Foundation

// MARK: - ApodModelElement
struct ApodModelElement: Codable, Identifiable, Equatable {
    var id = UUID()
    let copyright: String?
    let date: String?
    let explanation: String?
    let hdurl: String?
    let mediaType: String?
    let serviceVersion: String?
    let title: String?
    let url: String?
    var isLiked: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdurl
        case mediaType
        case serviceVersion
        case title
        case url
    }
    
    mutating func test(liked: Bool) {
        isLiked = liked
    }
}

typealias ApodModel = [ApodModelElement]
