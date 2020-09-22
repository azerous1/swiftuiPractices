//
//  fondationExtension .swift
//  practice3
//
//  Created by Yichi Zhang  on 9/15/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import Foundation

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
