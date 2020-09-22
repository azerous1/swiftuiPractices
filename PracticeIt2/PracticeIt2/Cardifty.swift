//
//  Cardifty.swift
//  PracticeIt2
//
//  Created by Yichi Zhang  on 9/11/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import Foundation
import SwiftUI

// A ViewModifier in which return a card-like view
// by putting the content from whoever calls this VM on top of a blue, rounded-corner card

struct Cardify : ViewModifier {
    
    // create a card view by putting the given content on top of a Rounded Retangle 
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.blue)
                VStack {
                    content.padding(.top, 25)
                }
            }
        }
    }
    
    // control panel
    private var cornerRadius : CGFloat = 20
    
}

// adding the function cardify as a VM to the view
extension View {
    func cardify() -> some View {
        self.modifier(Cardify())
    }
}
