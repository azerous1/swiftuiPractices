//
//  patternView.swift
//  PracticeIt
//
//  Created by Yichi Zhang  on 9/4/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI
import CoreData


// Return view for display a single practice entry in home page
// Display three piece of practice data: practice type, bpm, and length
// Has a "Card"-like view by calling the cardify VM. check the Code from the file directory 

struct practiceView: View {
    var practice : NSManagedObject
    
    // Saving each attribute from the Practice OBject as variables.
    // MARK: Not sure about the syntax below. Will revisit later. 
    var body: some View {
        var type = (practice as? Practice)?.type ?? "data error"
        var bpm = (practice as? Practice)?.bpm.removeZerosFromEnd() ?? "data error"
        var length = (practice as? Practice)?.sessionLength ?? "data error"
        
        if(bpm == "0") {
            bpm = "--"
        }
        
        if(length == "") {
            length = "--"
        }
        
        if(type == "") {
            type = "--"
        }
        
        return VStack(alignment: .leading) {
            Text("Practice type:      \(type)").padding(.bottom, 30).padding(.trailing, 30)
            Text("BPM:                         \(bpm)").padding(.bottom, 30)
            Text("Session length:   \(length) minutes").padding(.bottom, 30)
        }.font(.system(size: 25, weight: .bold, design: .rounded))
            .cardify().foregroundColor(Color.white)
    }
}
