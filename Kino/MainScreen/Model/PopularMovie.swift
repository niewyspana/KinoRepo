//
//  PopularMovie.swift
//  Kino
//
//  Created by Viktoriya Polozova on 17/09/2024.
//

import UIKit

struct PopularMoviesResponse: Codable {
    let items: [PopularMovie]
}

struct Genre: Codable {
    let genre: String
}

struct PopularMovie: Codable {
    let previewImageUrl: String
    let title: String
    let rating: Double?
    let genres: [Genre]
    let id: Int
    var image: UIImage?
    var duration: Int?
    
    enum CodingKeys: String, CodingKey {
        case previewImageUrl = "posterUrlPreview"
        case title = "nameRu"
        case rating = "ratingImdb"
        case genres = "genres"
        case id = "kinopoiskId"
        case duration = "filmLength"
    }
}
