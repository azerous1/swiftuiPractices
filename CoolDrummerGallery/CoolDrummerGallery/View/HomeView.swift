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
        ScrollView(.vertical) {
            DrummerRow(categoryName: "Jazz", drummers: drummerData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

     //List (categories, id: \categories.keys.sorted()) { key in
//DrummerRow(categoryName: "\(key)", drummers: self.categories[key]!)

        //}


//List {
//    ForEach(categories.keys.sorted(), id: \.self) {key in
//        DrummerRow(categoryName: "\(key)", drummers: self.categories[key]!)
//    }
//}