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
        VStack {
            Text(pattern.name)
            Text(String(pattern.BPM))
            Text(String(pattern.sessionLength))
        }
    }
}

