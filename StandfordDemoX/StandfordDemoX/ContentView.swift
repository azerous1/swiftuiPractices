//
//  EmojiMemoryGameView.swift
//  StandfordDemoX
//
//  Created by Yichi Zhang  on 7/27/20.
//

import SwiftUI
import Foundation

struct EmojiMemoryGameView: View  {
    var viewModel: EmojiMemoryGame
    var body: some View {
        let cardLayout = HStack {
            // attach our model to the view through view model
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
    // -- this is almost like a method inside a view
    // property: var inside a struct or class
        }.padding()
        .foregroundColor(Color.orange)
        if (EmojiMemoryGame.numberPair >= 5) {
            return cardLayout.font(Font.title)
        } else {
            return cardLayout.font(Font.largeTitle)
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                //calling a funtion on a view that return a view
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }.aspectRatio(0.66, contentMode: .fit)
    }
}

    // view: retangular area on screen
    // what is some view? - any struct that behave like a view .
    // there are a few type of view (combiner, view)
    // lego example is great
    // some view: return type ( Like java public static INT
    // return Text("🔥").padding()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}


