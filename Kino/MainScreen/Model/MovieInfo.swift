//
//  MovieInfo.swift
//  Kino
//
//  Created by Viktoriya Polozova on 20/08/2024.
//

import UIKit

final class MovieInfo {
    let previewImage: UIImage
    let title: String
    let rating: String
    let genres: [String]
    let duration: String
    
    init(previewImage: UIImage, 
         title: String,
         rating: String,
         genres: [String],
         duration: String) {
        self.previewImage = previewImage
        self.title = title
        self.rating = rating
        self.genres = genres
        self.duration = duration
    }
}
