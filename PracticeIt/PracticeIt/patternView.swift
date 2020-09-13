//
//  patternView.swift
//  PracticeIt
//
//  Created by Yichi Zhang  on 9/4/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI

struct patternView: View {
    var pattern : pattern
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Practice type:      \(pattern.name)").padding(.bottom, 30).padding(.trailing, 30)
            Text("BPM:                         \(String(pattern.BPM))").padding(.bottom, 30)
            Text("Session length:   \(String(pattern.sessionLength)) minutes").padding(.bottom, 30)
        }.font(.system(size: 25, weight: .bold, design: .rounded))
            .cardify().foregroundColor(Color.white)
    }
}


struct patternView_Previews: PreviewProvider {
    static var previews: some View {
        patternView(pattern: pattern(id: 2, name: "paradiddle", BPM: 160, detail: "i had fun", sessionLength: "20"))
    }
}
