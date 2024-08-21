//
//  MockMovieInfoStorage.swift
//  Kino
//
//  Created by Viktoriya Polozova on 20/08/2024.
//

import UIKit

class MockMovieInfoStorage {
    static let shared = MockMovieInfoStorage()
    var nowShowinMovies: [MovieInfo] = []
    var popularMovies: [MovieInfo] = []
    
    init() {
        createMovieInfos()
    }
    
    private func createMovieInfos() {
        let theNeverendingStory = MovieInfo(previewImage: UIImage(named: "image")!,
                                            title: "The Neverending Story",
                                            rating: "9.8/10.0 IMDb",
                                            genres: ["FANTASY"],
                                            duration: "1h 30m")
        
        nowShowinMovies.append(theNeverendingStory)
        
        let theNeverendingStory2 = MovieInfo(previewImage: UIImage(named: "NS2")!,
                                             title: "The Neverending Story 2",
                                             rating: "9.6/10.0 IMDb",
                                             genres: ["FANTASY", "ADVENTURE"],
                                             duration: "1h 40m")
        
        nowShowinMovies.append(theNeverendingStory2)
        
        let theNeverendingStory3 = MovieInfo(previewImage: UIImage(named: "NS3")!,
                                             title: "The Neverending Story 3",
                                             rating: "9.5/10.0 IMDb",
                                             genres: ["FANTASY"],
                                             duration: "1h 50m")
        
        nowShowinMovies.append(theNeverendingStory3)
        
        let twinPeaks = MovieInfo(previewImage: UIImage(named: "TwinPeaks")!,
                                  title: "Twin Peaks",
                                  rating: "9.5/10.0 IMDb",
                                  genres: ["THRILLER"],
                                  duration: "1h 50m")
        
        popularMovies.append(twinPeaks)
        
        let chungkingExpress  = MovieInfo(previewImage: UIImage(named: "CE")!,
                                          title: "Chungking Express",
                                          rating: "9.5/10.0 IMDb",
                                          genres: ["DRAMA"],
                                          duration: "1h 50m")
        
        popularMovies.append(chungkingExpress)
    }
}

