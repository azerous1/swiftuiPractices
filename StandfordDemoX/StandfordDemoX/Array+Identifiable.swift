//
//  Array+Identifiable.swift
//  StandfordDemoX
//
//  Created by Yichi Zhang  on 8/9/20.
//

import Foundation

// extend the array package with a new function that does the job of finding card with matching index
extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {// optional int
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil // return nil (not set) if not find the matching card
    }
}
