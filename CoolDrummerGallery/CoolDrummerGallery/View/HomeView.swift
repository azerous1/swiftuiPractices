//
//  ContentView.swift
//  CoolDrummerGallery
//
//  Created by Yichi Zhang  on 8/30/20.
//

import SwiftUI

// Main view of the applicaiton 
struct HomeView: View {
    
    var categories :  [String : [Drummer]] {
        .init(
            grouping: drummerData,
            by: {$0.category.rawValue}
        )
    }
    
    var body: some View {
        NavigationView { // this needs to be at the top level at most of the time 
            List {
                // id: \. is for specifying a key path
                ForEach(categories.keys.sorted(), id: \.self) {key in
                    DrummerRow(categoryName: "\(key)", drummers: self.categories[key]!)
                }
            }.padding(.top, 20)
            .navigationBarTitle("Drummer Gallery")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

