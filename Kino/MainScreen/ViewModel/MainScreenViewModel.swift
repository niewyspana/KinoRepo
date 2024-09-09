//
//  ViewModel.swift
//  Kino
//
//  Created by Viktoriya Polozova on 22/08/2024.
//

import Foundation

class MainScreenViewModel {
    var nowShowingMovies: [MovieInfo]
    var popularMovies: [MovieInfo]
    var coordinator: HomeScreenCoordinator?
    
    init(coordinator: HomeScreenCoordinator,
          nowShowingMovies: [MovieInfo],
          popularMovies: [MovieInfo]) {
        self.coordinator = coordinator
        self.nowShowingMovies = nowShowingMovies
        self.popularMovies = popularMovies
    }
    
    func didSelectNowShowing(at indexPath: IndexPath) {
        let movieInfo = nowShowingMovies[indexPath.row]
        guard let coordinator = coordinator else {
            print("Coordinator is not set")
            return
        }
        coordinator.goToDetailsScreen()
    }
    
    func didSelectPopular(at indexPath: IndexPath) {
        let movieInfo = popularMovies[indexPath.row]
        guard let coordinator = coordinator else {
            print("Coordinator is not set")
            return
        }
        coordinator.goToDetailsScreen()
    }
    
    func seeMorePressed() {
        coordinator?.goToSeeMore()
    }
}
