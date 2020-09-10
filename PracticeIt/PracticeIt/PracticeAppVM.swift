//
//  PracticeAppVM.swift
//  PracticeIt
//
//  Created by Yichi Zhang  on 9/4/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import Foundation

class practiceData : ObservableObject {
    
    @Published var data = [pattern]()
    
    var practiceType = ["Any", "Rudiments", "Song", "Chops", "Groove"]
    
    var practiceLengthOptions = ["15", "30", "45", "60", "75", "90", "115", "120", "more than 120 minutes"]
    
}
