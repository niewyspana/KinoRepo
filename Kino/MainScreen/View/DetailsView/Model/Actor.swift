//
//  Actor.swift
//  Kino
//
//  Created by Viktoriya Polozova on 27/08/2024.
//

import UIKit

//struct Actor {
//    let fullName: String
//    let imageName: String
//    
//    var avatar: UIImage? {
//        return UIImage(named: imageName)
//    }
//}

struct ActorResponse: Codable {
    let fullName: String
    let imageUrl: String
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "nameRu"
        case imageUrl = "posterUrl"
    }
}
