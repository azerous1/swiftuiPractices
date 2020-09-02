//
//  EmojiMemoryGame.swift
//  StandfordDemoX
//
//  Created by Yichi Zhang  on 7/29/20.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    //can't use an instacne of funciton before itself is initialized
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    // a property wrapper, adding property to a varable 
    
    static var numberPair = Int.random(in: 1...5)
    
    
    private static func createMemoryGame() -> MemoryGame<String>{
        let emojis = ["🥰", "😘", "🐻", "😰", "🐨"]
        let oceanTheme = ["🐬", "🐋", "🦐", "🐟", "🦀"]
        return MemoryGame<String>(numberOfPairsOfCards: 5) { pairIndex in
            return emojis[pairIndex]
        }
    }
     
    // a glass door; outside can see and can't modify it.
   
    // access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //    - intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
