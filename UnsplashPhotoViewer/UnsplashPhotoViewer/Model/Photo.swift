//
//  Photo.swift
//  UnsplashPhotoViewer
//
//  Created by Yichi Zhang  on 9/2/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI

struct Photo : Decodable, Identifiable {
    var id : String
    var alt_description : String?
    var urls: [String : String]
}
 
class UnsplashData: ObservableObject {
    @Published var photoArray: [Photo] = []
    
    init() {
        loadData()
    }
    
    // MARK: load function not working; specifically line 39
    func loadData() {
        let key = "rs9onS18cRHPfjTUTzcY4FbciPu04AIqz0TiWw3fiNo"
        let url = "https://api.unsplash.com/photos/random/?count=30&client_id=\(key)"
        print(url)
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            guard let data = data else {
                print("URLSession dataTask error:", error ?? "nil")
                return
            }
            
            print(data)
            do {
                
                let json = try JSONDecoder().decode([Photo].self, from: data)
                for photo in json {
                    DispatchQueue.main.async {
                        self.photoArray.append(photo)
                    }
                }
            } catch {
                print("yo check this out")
                print(error)
            }
        }.resume() 
    }
    
    
}
