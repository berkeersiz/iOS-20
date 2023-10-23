//
//  Yonetmenler.swift
//  MovieS
//
//  Created by Berke Ersiz on 9.02.2023.
//

import Foundation

class Yonetmenler:Codable {
    var yonetmen_id:String?
    var yonetmen_ad:String?
    
    init() {
        
    }
    
    init(yonetmen_id:String,yonetmen_ad:String) {
        self.yonetmen_id = yonetmen_id
        self.yonetmen_ad = yonetmen_ad
    }
}
