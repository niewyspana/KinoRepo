//
//  DetailsViewModel.swift
//  Kino
//
//  Created by Viktoriya Polozova on 27/08/2024.
//

import UIKit

class DetailsViewModel {
    
    private let interactor: DetailsScreenInteractor
    var model: MovieDetailedInfoResponce?
    
    var actors: [ActorResponse] = []
    
    var onDetailsLoaded: (() -> Void)?
    var onError: ((Error) -> Void)?
    var onCastLoaded: (() -> Void)?
    
    init(interactor: DetailsScreenInteractor) {
        self.interactor = interactor
    }
    
    func loadDetails() {
        interactor.fetchDetailsMovie { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.model = movieDetails
                self?.loadImage(from: movieDetails.previewImageUrl) { image in
                    self?.model?.image = image
                    DispatchQueue.main.async {
                        self?.onDetailsLoaded?()
                    }
                }
            case .failure(let error):
                self?.onError?(error)
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
    
    private func loadDetailsImagesForMovie(_ movies: [MovieDetailedInfoResponce], completion: @escaping ([MovieDetailedInfoResponce]) -> Void) {
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
    
    func loadCast() {
            interactor.fetchCast { [weak self] result in
                switch result {
                case .success(let castResponses):
                    self?.actors = castResponses
                    self?.loadImageForCast(castResponses) { updatedActors in
                        self?.actors = updatedActors
                        DispatchQueue.main.async {
                            self?.onCastLoaded?()
                        }
                    }
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
        
        private func loadImageForCast(_ cast: [ActorResponse], completion: @escaping ([ActorResponse]) -> Void) {
            var updatedActors = cast
            let group = DispatchGroup()
            
            for (index, actor) in cast.enumerated() {
                group.enter()
                loadImage(from: actor.imageUrl) { image in
                    updatedActors[index].image = image
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                completion(updatedActors)
            }
        }
    
    func didTapList() {
        
    }
    
    func didTapBack() {
        
    }
    
    func didTapPlayTrailer() {
        
    }
    
    func didTapSeeMore() {
        
    }
}
