//
//  FruitViewModel .swift
//  FruitRecommendationApp
//
//  Created by Yichi Zhang  on 8/14/20.
//

import SwiftUI
import Foundation

class FruitViewModel : ObservableObject {
    @Published var fruitModel = FruitViewModel.createFruitRecommdationApp()
    
    static func createFruitRecommdationApp() -> FruitModel {
        let fruits = ["🍎", "🍑", "🥭", "🍉", "🍊", "🍌", "🥥", "🌶"]
        return FruitModel(fruitArray: fruits)
    }
    
    func getRecommdation() {
        fruitModel.startRecommending()
    }
    
    func getFruit() -> String? {
        fruitModel.currentFruit
    }
}
