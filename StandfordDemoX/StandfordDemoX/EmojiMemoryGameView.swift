//
//  EmojiMemoryGameView.swift
//  StandfordDemoX
//
//  Created by Yichi Zhang  on 7/27/20.
//

import SwiftUI
import Foundation

struct EmojiMemoryGameView: View  {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: cardFlipAnimationDuration)) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(paddingSize)
        // -- this is almost like a method inside a view
        // property: var inside a struct or class
            }.padding()
             .foregroundColor(Color.orange)
            Button(action: {
                // this is explicit animation
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: {
                Text("New Game"). // can be internationalize
            })
        }
    }
    
    private let cardFlipAnimationDuration : Double = 0.75
    private let paddingSize : CGFloat = 5
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    // animate when the "animatedBonusRemaining" var goes toward 0
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    // so this function either return a list of view (a big combination of view), or nothing (empty view), which solve the opaque return type issue in the "else" case of if which is empty// so this function either return a list of view (a big combination of view), or nothing (empty view), which solve the opaque return type issue in the "else" case of if which is empty
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                //calling a funtion on a view that return a view
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                //animate using the new variable 
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }.padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 0.5).repeatForever(autoreverses: false) : .default)
                // this is an implicit animation
                // need to stop repeatForever if car is not matched 
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)// not sure why putting the code here
        }
    }
    
    // drawing constant
    // let is a constant
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    private let fontScaleFactor: CGFloat = 0.7
}

    // view: retangular area on screen
    // what is some view? - any struct that behave like a view .
    // there are a few type of view (combiner, view)
    // lego example is great
    // some view: return type ( Like java public static INT
    // return Text("🔥").padding()
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[2])
        return EmojiMemoryGameView(viewModel: game)
    }
}


