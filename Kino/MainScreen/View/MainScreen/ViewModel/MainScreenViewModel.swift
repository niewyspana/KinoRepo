//
//  ViewModel.swift
//  Kino
//
//  Created by Viktoriya Polozova on 22/08/2024.
//

import UIKit

class MainScreenViewModel {
    private(set) var nowShowingMovies: [NowShowingMovie] = []
    private(set) var popularMovies: [PopularMovie] = []
    
    var onNowShowingMoviesLoaded: (() -> Void)?
    var onPopularMoviesLoaded: (() -> Void)?
    
    let interactor: MainScreenInteractor
    var coordinator: HomeScreenCoordinator?
    
    init(coordinator: HomeScreenCoordinator, interactor: MainScreenInteractor) {
        self.coordinator = coordinator
        self.interactor = interactor
    }
    
    func loadNowShowingMovies() {
        interactor.fetchNowShowing { [weak self] result in
            switch result {
            case .success(let movies):
                self?.nowShowingMovies = movies
                self?.loadNowShowingImagesForMovies(movies) { [weak self] updatedMovies in
                    DispatchQueue.main.async {
                        self?.nowShowingMovies = updatedMovies
                        self?.onNowShowingMoviesLoaded?()
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func loadPopularMovies() {
        interactor.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.popularMovies = movies
                self?.loadPopularImagesForMovies(movies) { [weak self] updatedMovies in
                    DispatchQueue.main.async {
                        self?.popularMovies = updatedMovies
                        self?.onPopularMoviesLoaded?()
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    private func loadNowShowingImagesForMovies(_ movies: [NowShowingMovie], completion: @escaping ([NowShowingMovie]) -> Void) {
        var updatedMovies = movies
        let group = DispatchGroup()
        
        for (index, movie) in movies.enumerated() {
            group.enter()
            loadImage(from: movie.previewImageUrl) { image in
                updatedMovies[index].image = image
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(updatedMovies)
        }
    }
    
    private func loadPopularImagesForMovies(_ movies: [PopularMovie], completion: @escaping ([PopularMovie]) -> Void) {
        var updatedMovies = movies
        let group = DispatchGroup()
        
        for (index, movie) in movies.enumerated() {
            group.enter()
            loadImage(from: movie.previewImageUrl) { image in
                updatedMovies[index].image = image
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(updatedMovies)
        }
    }
    
    func didSelectNowShowing(at indexPath: IndexPath) {
        let movieInfo = nowShowingMovies[indexPath.row]
        guard let coordinator = coordinator else {
            print("Coordinator is not set")
            return
        }
        coordinator.goToDetailsScreen(movieId: movieInfo.id)
    }
    
    func didSelectPopular(at indexPath: IndexPath) {
        let movieInfo = popularMovies[indexPath.row]
        guard let coordinator = coordinator else {
            print("Coordinator is not set")
            return
        }
        coordinator.goToDetailsScreen(movieId: movieInfo.id)
    }
    
    func seeMorePressed() {
        coordinator?.goToSeeMore()
    }
}
