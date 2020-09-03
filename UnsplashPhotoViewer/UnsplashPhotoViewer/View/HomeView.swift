//
//  ContentView.swift
//  UnsplashPhotoViewer
//
//  Created by Yichi Zhang  on 9/2/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var randomImages = UnsplashData()
    
    var body: some View {
        Text("Hello, World!").onTapGesture {
            print(self.randomImages)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
