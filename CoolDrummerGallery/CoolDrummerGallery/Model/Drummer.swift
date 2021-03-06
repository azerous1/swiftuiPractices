//
//  Drink.swift
//  CoolDrummerGallery
//
//  Created by Yichi Zhang  on 8/30/20.
//

import Foundation
import SwiftUI

// Drummer type
struct Drummer: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var category: Category
    var description: String
    
    enum Category: String, CaseIterable, Hashable, Codable {
        case HipHop = "Hip-hop"
        case progRock = "Progressive rock"
        case jazz = "Jazz"
    }
 
    // MARK:Required for implementing Codable
    func encode(to: Encoder) {}
    
    init(from: Decoder, id: Int, name: String, imageName: String, category: Category, description: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.category = category
        self.description = description
    }
}

