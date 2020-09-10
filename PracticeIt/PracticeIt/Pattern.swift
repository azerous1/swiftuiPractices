//
//  Pattern.swift
//  PracticeIt
//
//  Created by Yichi Zhang  on 9/4/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import Foundation

struct pattern : Identifiable {
    var id : Int
    var name : String
    var BPM : Double
    var detail : String
    // sessionLength should be implement with picker. will check it later
    var sessionLength : String
    
    init(id: Int, name : String, BPM: Double, detail: String, sessionLength: String) {
        self.id = id
        self.name = name
        self.BPM = BPM
        self.detail = detail
        self.sessionLength = sessionLength
    }
    
}


