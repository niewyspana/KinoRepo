//
//  DetailsScreenInteractor.swift
//  Kino
//
//  Created by Viktoriya Polozova on 19/09/2024.
//

import Foundation

class DetailsScreenInteractor {
    
    private var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    func fetchDetailsMovie(completion: @escaping (Result<MovieDetailedInfoResponce, Error>) -> Void) {
        APIManager.fetchDetailsMovie(movieId: movieId, completion: completion)
    }
    func fetchCast(completion: @escaping (Result<[ActorResponse], Error>) -> Void) {
        APIManager.fetchCast(movieId: movieId, completion: completion)
    }
}
