//
//  MemoryGameModel.swift
//  StandfordDemoX
//
//  Created by Yichi Zhang  on 7/29/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {

    // setting the varable is privatre, reading it isn't
    private(set) var cards: Array<Card>
    
    // all optionals get initialized with nil automatically
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // get: return the index of the indexOfTheOneAndOnlyFaceUpCard 
        get {
            return cards.indices.filter { (index) -> Bool in cards[index].isFaceUp}.only
        }
        set {
            // the newValue variable only exists in "set". It's the newValue that is being set to the var
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // used for initialize this MemoryGame Struct
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card)  {
        // the if let things render the chonseIndex ONLY exist if it is not nil.
        // let chosenIndex exist if the chosen card is 1. in the array, 2: is face down, 3: is unmatched
       
        // if the chosen card is in the array, is not face up, and is not matched
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            // if the indexOfTheOneAndOnlyFaceUpCard exists (non - nil) - then start the matching process
            // else set the indexOfTheOneAndOnlyFaceUpCard to the current index
            // QUESTION: how does the indexOfTheOneAndOnlyFaceUpCard reset itself? 
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    // function that returns the index of the chosen card in the cards array
    // using ex and internal name
    
    // use the identifiable protocol
    // kinda like react where each "card" or element need a key prop
    struct Card: Identifiable {
        // use property oberserver to start / stop bonus time (more reliable since it's one for all)
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var id: Int
        
        
        // MARK: - Bonus Time functionality
        // give user bonus point
        // if user matched the card before the pie goes off
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
         
        // how long does this card had ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (anmd is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e.  not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus oppotunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // wheter the card earned bonus point
        // whether the card was match during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus time window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down or get matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
