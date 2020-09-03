 //
//  aDrummer.swift
//  CoolDrummerGallery
//
//  Created by Yichi Zhang  on 8/30/20.
//

import SwiftUI

 // Return a few for one drummer 
struct aDrummer: View {
    
    // data of a drummer
    var drummer : Drummer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Image(drummer.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
            VStack(alignment: .leading, spacing: -5){ // negative number works 
                Text(drummer.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                    .padding(.bottom, 15)
                Text(drummer.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .frame(height: 180)
            }
        }
    }
}
