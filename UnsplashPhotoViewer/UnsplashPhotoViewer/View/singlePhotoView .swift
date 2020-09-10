//
//  singlePhotoView .swift
//  UnsplashPhotoViewer
//
//  Created by Yichi Zhang  on 9/3/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI

struct singlePhotoView_: View {
    var photo : Photo
    
    var body: some View {
        Text("")
    }
}

struct singlePhotoView__Previews: PreviewProvider {
    static var previews: some View {
        singlePhotoView_(photo: UnsplashData().photoArray[0] )
    }
}
