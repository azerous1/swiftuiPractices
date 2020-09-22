//
//  PracticeAppVM.swift
//  PracticeIt
//
//  Created by Yichi Zhang  on 9/4/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

class userOptionData : ObservableObject {
    
    var newType : String = ""
    var newDetail : String = ""
    // allow view to monitor the change of this var and re-draw itself when changes happened.
    @Published var newBPM : Double = 0
    var newLength : String = ""
    
    var practiceType = ["Any", "Rudiments", "Song", "Chops", "Groove", "Others"]
    
    var practiceLengthOptions = ["15", "30", "45", "60", "75", "90", "115", "120", "more than 120 minutes"] 
}
