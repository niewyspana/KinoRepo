//
//  MovieDetailedInfo.swift
//  Kino
//
//  Created by Viktoriya Polozova on 27/08/2024.
//

import UIKit

struct MovieDetailedInfoResponce: Codable {
    let previewImageUrl: String
    var image: UIImage?
    let title: String
    var imdbRating: Double?
    var rating: Double?
    let genres: [MovieGenre]
    let year: Int
    var duration: Int?
    let descriptionText: String
    
    enum CodingKeys: String, CodingKey {
        case previewImageUrl = "posterUrl"
        case title = "nameRu"
        case imdbRating = "ratingImdb"
        case rating = "ratingFilmCritics"
        case genres
        case year = "year"
        case duration = "filmLength"
        case descriptionText = "description"
    }
}
