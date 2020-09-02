//
//  ContentView.swift
//  CoolDrummerGallery
//
//  Created by Yichi Zhang  on 8/30/20.
//

import SwiftUI

struct HomeView: View {
    
    var categories:[String : [Drummer]] {
        .init(
            grouping: drummerData,
            by: {$0.category.rawValue}
        )
    }
    
    var body: some View {
        Text("chops")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
