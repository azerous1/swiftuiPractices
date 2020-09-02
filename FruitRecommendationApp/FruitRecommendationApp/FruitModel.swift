//
//  FruitModel.swift
//  FruitRecommendationApp
//
//  Created by Yichi Zhang  on 8/14/20.
//

import Foundation

struct FruitModel {
    var fruits: Array<String>
    
    init(fruitArray: Array<String>) {
        fruits = Array<String>()
        for index in 0..<fruitArray.count {
            fruits.append(fruitArray[index])
        }
    }
    
    var currentFruit: String?
    
    // Basic fruit geenrator. Will add the int parameter for generate specific amout of fruit later.
    mutating func startRecommending() {
        let randomIndex = Int.random(in: 0..<fruits.count)
        currentFruit = fruits[randomIndex]
    }
}




