//
//  practiceDetailView .swift
//  PracticeIt2
//
//  Created by Yichi Zhang  on 9/11/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI

struct practiceDetailView: View {
    var pattern : pattern
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Practice type:      \(pattern.name)").padding(.bottom, 30).padding(.trailing, 30)
            Text("BPM:                         \(String(pattern.BPM))").padding(.bottom, 30)
            Text("Session length:   \(String(pattern.sessionLength)) minutes").padding(.bottom, 30)
            Text("Details:").padding(.bottom, 20)
            Text(pattern.detail).padding(.bottom, 30).font(.system(size: 20)).multilineTextAlignment(.leading)
            // height affect the padding between the detail indicator and the detail text. will fix it later.
            .navigationBarTitle("Practice Detail")
        }.font(.system(size: 25, weight: .bold, design: .rounded))
            .cardify().foregroundColor(Color.white).frame(width: 350)
    }
}

struct patternDetailView_Previews: PreviewProvider {
    static var previews: some View {
        practiceDetailView(pattern: pattern(id: 2, name: "rudiments", BPM: 160, detail: "Antonio Sánchez (born November 1, 1971) is a Mexican-American jazz drummer and composer best known for his work with jazz guitarist Pat Metheny.[1] In 2014, his popularity increased when he composed an original film score for Birdman, directed by Alejandro G. Iñárritu.[2] The soundtrack album was released on October 14, 2014.[3] The score earned him a nomination for the Golden Globe Award for Best Original Score[4] and BAFTA Award for Best Film Music; he won the Critics' Choice Movie Award for Best Score and Satellite Award for Best Original Score.", sessionLength: "20"))
    }
}
