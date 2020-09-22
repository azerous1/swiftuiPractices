//
//  Coordinator.swift
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
class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate {

    var dynamicHeightTextField: DynamicHeightTextField
    

    init(dynamicHeightTextField: DynamicHeightTextField) {
        self.dynamicHeightTextField = dynamicHeightTextField
    }

    func textViewDidChange(_ textView: UITextView) {
        self.dynamicHeightTextField.text = textView.text
    }

    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    weak var textView: UITextView?
       
       func layoutManager(
           _ layoutManager: NSLayoutManager,
           didCompleteLayoutFor textContainer: NSTextContainer?,
           atEnd layoutFinishedFlag: Bool) {
           
           DispatchQueue.main.async { [weak self] in
               guard let view = self?.textView else {
                   return
               }
               let size = view.sizeThatFits(view.bounds.size)
               if self?.dynamicHeightTextField.height != size.height {
                   self?.dynamicHeightTextField.height = size.height
               }
           }

       }
}


