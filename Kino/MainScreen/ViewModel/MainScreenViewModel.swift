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
    
    init (coordinator: HomeScreenCoordinator,
          nowShowingMovies: [MovieInfo],
          popularMovies: [MovieInfo]) {
        self.coordinator = coordinator
        self.nowShowingMovies = nowShowingMovies
        self.popularMovies = popularMovies
    }
    
    func didSelectNowShowing(at indexPath: IndexPath) {
        let movieInfo = nowShowingMovies[indexPath.row]
        if let coordinator = coordinator {
            coordinator.goToDetailsScreen()
        } else {
            print("Coordinator is not set")
        }
    }
    
    func seeMorePressed() {
        coordinator?.goToSeeMore()
    }
}
