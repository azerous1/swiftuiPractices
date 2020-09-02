//
//  RoundButton.swift
//  Calculator2X
//
//  Created by Yichi Zhang  on 7/26/20.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var roundButton:Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}
