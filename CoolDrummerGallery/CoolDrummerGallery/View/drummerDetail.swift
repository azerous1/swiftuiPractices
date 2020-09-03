//
//  drummerDetail.swift
//  CoolDrummerGallery
//
//  Created by Yichi Zhang  on 9/1/20.
//

import SwiftUI


// Detail view page. Shown whn user clicked the view of one particular drummer
struct drummerDetail: View {
    
    var drummer : Drummer
    
    var body: some View {
        List {
            ZStack (alignment: .bottom){
                Image(drummer.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Rectangle().frame(height: 80)
                    .opacity(0.35)
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
            }.listRowInsets(EdgeInsets())
            VStack(alignment: .leading) {
                Text(drummer.description)
                .lineSpacing(10)
                    .font(.body)
                    .foregroundColor(.primary)
                HStack {
                    Spacer()
                    moreInfoButton()
                    Spacer()
                }
            }.padding(.top)
        }
        .edgesIgnoringSafeArea(.top
        )
    }
}

struct moreInfoButton : View {
    var body: some View {
        Button(action: {}) {
            Text("More Info")
        }
        .frame(width: 200, height: 50)
        .background(Color.blue)
        .foregroundColor(Color.white)
    .cornerRadius(20)
        .padding(.top, 50)
        .padding(.bottom, 50)
        .font(.headline)
    }
}

struct drummerDetail_Previews: PreviewProvider {
    static var previews: some View {
        drummerDetail(drummer : drummerData[4])
    }
}
