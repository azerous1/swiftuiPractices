//
//  ContentView.swift
//  FruitRecommendationApp
//
//  Created by Yichi Zhang  on 8/14/20.
//

import SwiftUI

struct FruitView: View {
    // the size of the fruit emoji string
    private let fruitSize : CGFloat = 80
    
    @ObservedObject var viewModel: FruitViewModel
    
    var body: some View {
        
        Text("Start random fruit recommednation?").padding(.top, 200).padding(.bottom, 100).font(Font.system(size: 20))
        Button(action: {viewModel.getRecommdation()}, label: {
                Text("Yes!")
        }).font(Font.system(size: 40))
        
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 20).fill(Color.white).edgesIgnoringSafeArea([.bottom])
                if viewModel.getFruit() != nil {
                    Text(viewModel.getFruit()!).font(Font.system(size: fruitSize))
                }
            }
            // MARK: -  current animaiton only animate the first fruit recommeded. Fix latet
        }.animation(Animation.linear(duration: 0.5)).transition(.identity)
    }
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        let fruit = FruitViewModel()
        return FruitView(viewModel: fruit)
    }
}
