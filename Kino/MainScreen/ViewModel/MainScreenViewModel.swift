//
//  ViewModel.swift
//  Kino
//
//  Created by Viktoriya Polozova on 22/08/2024.
//

import Foundation

class MainScreenViewModel {
    var nowShowingMovies: [MovieInfo] {
        MockMovieInfoStorage.shared.nowShowingMovies
    }
    
    var popularMovies: [MovieInfo] {
        MockMovieInfoStorage.shared.popularMovies
    }
    
    func didSelectNowShowing(at indexPath: IndexPath) {
        let moviewInfo = nowShowingMovies[indexPath.row]
        // use coordinator here to present next screen
    }
}
