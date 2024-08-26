//
//  ViewModel.swift
//  Kino
//
//  Created by Viktoriya Polozova on 22/08/2024.
//

import Foundation

class MainScreenViewModel {
    
    var coordinator: HomeScreenCoordinator!
    init (coordinator: HomeScreenCoordinator) {
        self.coordinator = coordinator
    }
    
    var nowShowingMovies: [MovieInfo] {
        MockMovieInfoStorage.shared.nowShowingMovies
    }
    
    var popularMovies: [MovieInfo] {
        MockMovieInfoStorage.shared.popularMovies
    }
    
    func didSelectNowShowing(at indexPath: IndexPath) {
        let movieInfo = nowShowingMovies[indexPath.row]
        coordinator.goToDetailsScreen()
    }
}
