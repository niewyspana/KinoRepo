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
        Task {
            let result = try await APIManager.fetchDetailsMovie(movieId: movieId)
            completion(result)
        }
    }
    func fetchCast(completion: @escaping (Result<[ActorResponse], Error>) -> Void) {
        Task {
            let result = try await APIManager.fetchCast(movieId: movieId)
            completion(result)
        }
    }
}
