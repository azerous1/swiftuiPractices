//
//  DrummerRow.swift
//  CoolDrummerGallery
//
//  Created by Yichi Zhang  on 9/1/20.
//

import SwiftUI

// Return a row of "adrummer" view.
struct DrummerRow: View {
    
    // name of drummer catagory
    var categoryName : String

    // An array of drummers
    var drummers : [Drummer]
    
    // MARK: Issue with navigation view and links. Cannot navigate to the drummer detail page right now. Will visit later. 
    var body: some View {
        // I tried to embed the entire VStack into NaviationView. However, it ends up showing nothing as well
        
        
        // MARK: Solution: put whatever triggers the navigationLink into its closure. In this case, it is the "aDrummer" view ! SOOO happy!
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.title).padding(.top, 15)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach (self.drummers) { drummer in
                        NavigationLink(destination: drummerDetail(drummer: drummer)) {
                            aDrummer(drummer: drummer)
                            .frame(width: 300)
                            .padding(.trailing, 30)
                        }
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
