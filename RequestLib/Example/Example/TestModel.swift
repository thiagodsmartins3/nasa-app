//
//  TestModel.swift
//  Example
//
//  Created by Thiago dos Santos Martins on 31/01/25.
//

import Foundation

// MARK: - TestModel
struct TestModel: Codable {
    let cep: String?
    let state: String?
    let city: String?
    let neighborhood: String?
    let street: String?
    let service: String?

    enum CodingKeys: String, CodingKey {
        case cep
        case state
        case city
        case neighborhood
        case street
        case service
    }
}
