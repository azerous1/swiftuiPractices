//
//  ContentView.swift
//  UnsplashPhotoViewer
//
//  Created by Yichi Zhang  on 9/2/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @ObservedObject var randomImages = UnsplashData()
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                ForEach (randomImages.photoArray, id: \.id) { photo in
                    Group {
                         WebImage(url: URL(string: photo.urls["thumb"]!))
                                          .resizable()
                                              .aspectRatio(contentMode: .fill)
                                              .frame(width: UIScreen.main.bounds.width - 50, height: 200, alignment: .center)
                                          .cornerRadius(15)
                        Text(photo.alt_description!).font(.footnote)
                    }
                }
            }.padding(20)
            .navigationBarTitle("Photo List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
