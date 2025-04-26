//
//  Item.swift
//  KeepTraining
//
//  Created by Juan Francisco Bazan Carrizo on 28/01/2025.
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
