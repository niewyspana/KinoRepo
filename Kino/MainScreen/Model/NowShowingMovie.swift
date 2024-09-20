//
//  NowShowingMovie.swift
//  Kino
//
//  Created by Viktoriya Polozova on 17/09/2024.
//

import UIKit

struct NowShowingMoviesResponse: Codable {
    let items: [NowShowingMovie]
}

struct NowShowingMovie: Codable {
    let previewImageUrl: String
    let title: String
    let id: Int
    var image: UIImage?
    //let rating: String
    
    enum CodingKeys: String, CodingKey {
        case previewImageUrl = "posterUrlPreview"
        case title = "nameRu"
        case id = "kinopoiskId"
      //  case rating = "ratingKinopoisk"
    }
}
