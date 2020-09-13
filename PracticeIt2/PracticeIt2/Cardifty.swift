//
//  Cardifty.swift
//  PracticeIt2
//
//  Created by Yichi Zhang  on 9/11/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import Foundation
import SwiftUI

struct Cardify : ViewModifier {
    
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
