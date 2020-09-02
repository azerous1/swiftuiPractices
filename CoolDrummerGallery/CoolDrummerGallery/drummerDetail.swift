//
//  drummerDetail.swift
//  CoolDrummerGallery
//
//  Created by Yichi Zhang  on 9/1/20.
//

import SwiftUI

struct drummerDetail: View {
    
    var drummer : Drummer
    
    var body: some View {
        ZStack (alignment: .bottom){
            Image(drummer.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Rectangle().frame(height: 80)
                .opacity(0.25)
            .blur(radius: 10)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(drummer.name)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                .padding(.leading).padding(.bottom)
                Spacer() // why adding spacer will render the text move to the left?
            }
        }
    }
}

struct drummerDetail_Previews: PreviewProvider {
    static var previews: some View {
        drummerDetail(drummer : drummerData[4])
    }
}
