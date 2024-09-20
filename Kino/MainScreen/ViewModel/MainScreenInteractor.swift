//
//  MainScreenInteractor.swift
//  Kino
//
//  Created by Viktoriya Polozova on 18/09/2024.
//

import Foundation

class MainScreenInteractor {
    func fetchNowShowing(completion: @escaping (Result<[NowShowingMovie], Error>) -> Void) {
        APIManager.fetchNowShowingMovies(completion: completion)
    }
    func fetchPopularMovies(completion: @escaping (Result<[PopularMovie], Error>) -> Void) {
        APIManager.fetchPopularMovies(page: 1, completion: completion)
    }
}
