//
//  MovieDetailedInfo.swift
//  Kino
//
//  Created by Viktoriya Polozova on 27/08/2024.
//

import UIKit

final class MovieDetailedInfo {
    let previewImage: UIImage
    let title: String
    let imdbRating: String
    let rating: String
    let genres: [String]
    let language: String
    let duration: String
    let descriptionText: String
    let cast: [Actor]
    
    init(previewImage: UIImage,
         title: String,
         imdbRating: String,
         rating: String,
         genres: [String],
         language: String,
         duration: String,
         descriptionText: String,
         cast: [Actor]) {
        self.previewImage = previewImage
        self.title = title
        self.imdbRating = imdbRating
        self.rating = rating
        self.genres = genres
        self.language = language
        self.duration = duration
        self.descriptionText = descriptionText
        self.cast = cast
    }
}
