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
    let genres: [MovieGenre]
    var imdbRating: Double?
    
    enum CodingKeys: String, CodingKey {
        case previewImageUrl = "posterUrlPreview"
        case title = "nameRu"
        case id = "kinopoiskId"
        case genres
        case imdbRating = "ratingImdb"
    }
}

struct MovieGenre: Codable {
    let genre: String
}
