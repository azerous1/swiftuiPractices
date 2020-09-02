//
//  Array+only.swift
//  StandfordDemoX
//
//  Created by Yichi Zhang  on 8/10/20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}


