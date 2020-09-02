//
//  DrummerRow.swift
//  CoolDrummerGallery
//
//  Created by Yichi Zhang  on 9/1/20.
//

import SwiftUI

struct DrummerRow: View {
    
    var categoryName : String
    var drummers : [Drummer]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach (self.drummers) { drummer in
                        aDrummer(drummer: drummer)
                        .frame(width: 300)
                        .padding(.trailing, 30)
                    }
                }
            }
            .padding()
        }
    }
}

struct DrummerRow_Previews: PreviewProvider {
    static var previews: some View {
        DrummerRow(categoryName: "Hip-hop", drummers: drummerData)
    }
}
