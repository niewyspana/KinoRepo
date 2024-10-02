//
//  MainScreenInteractor.swift
//  Kino
//
//  Created by Viktoriya Polozova on 18/09/2024.
//

import Foundation

class MainScreenInteractor {
    
    func fetchNowShowing(completion: @escaping (Result<[NowShowingMovie], Error>) -> Void) {
        Task {
            let result = try await APIManager.fetchNowShowingMoviesWithRatings()
            completion(result)
        }
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[PopularMovie], Error>) -> Void) {
        Task {
            let result = try await APIManager.fetchPopularMoviesWithDuration(page: 1)
            completion(result)
        }
    }
}
