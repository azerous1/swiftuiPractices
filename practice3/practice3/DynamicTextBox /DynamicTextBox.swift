//
//  DynamicTextBox.swift
//  practice3
//
//  Created by Yichi Zhang  on 9/15/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


// For implement dynamic height text box for entering Detail
// Code found online. This snippet is partially based on UIKit which
// currently I didn't learn. Thankfully it works! 
struct DynamicHeightTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        
        textView.isScrollEnabled = true
        textView.alwaysBounceVertical = false
        
        textView.text = text
        textView.backgroundColor = UIColor.clear
        
        
        context.coordinator.textView = textView
        textView.delegate = context.coordinator
        textView.layoutManager.delegate = context.coordinator


        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
           return Coordinator(dynamicHeightTextField: self)
       }
}
