//
//  Item.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 30/01/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
