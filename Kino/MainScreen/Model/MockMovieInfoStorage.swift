//
//  MockMovieInfoStorage.swift
//  Kino
//
//  Created by Viktoriya Polozova on 20/08/2024.
//

import UIKit

class MockMovieInfoStorage {
    static let shared = MockMovieInfoStorage()
    var nowShowingMovies: [MovieInfo] = []
    var popularMovies: [MovieInfo] = []
    
    init() {
        fillNowShowingMovieInfos()
        fillPopularMovieInfos()
    }
    
    private func fillNowShowingMovieInfos() {
        let theNeverendingStory = MovieInfo(previewImage: UIImage(named: "image")!,
                                            title: "The Neverending Story",
                                            rating: "9.8/10.0 IMDb",
                                            genres: ["FANTASY"],
                                            duration: "1h 30m")
        
        nowShowingMovies.append(theNeverendingStory)
        
        let theNeverendingStory2 = MovieInfo(previewImage: UIImage(named: "NS2")!,
                                             title: "The Neverending Story 2",
                                             rating: "9.6/10.0 IMDb",
                                             genres: ["FANTASY", "ADVENTURE"],
                                             duration: "1h 40m")
        
        nowShowingMovies.append(theNeverendingStory2)
        
        let theNeverendingStory3 = MovieInfo(previewImage: UIImage(named: "NS3")!,
                                             title: "The Neverending Story 3",
                                             rating: "9.5/10.0 IMDb",
                                             genres: ["FANTASY"],
                                             duration: "1h 50m")
        
        nowShowingMovies.append(theNeverendingStory3)
    }
    
    private func fillPopularMovieInfos() {
        let twinPeaks = MovieInfo(previewImage: UIImage(named: "TwinPeaks")!,
                                  title: "Twin Peaks",
                                  rating: "9.5/10.0 IMDb",
                                  genres: ["DRAMA", "FANTASY & DRAMA", "ADVENTURE & THRILLER", "COMEDY", "FANTASY & COMEDY"],
                                  duration: "1h 50m")
        
        popularMovies.append(twinPeaks)
        
        let chungkingExpress  = MovieInfo(previewImage: UIImage(named: "CE")!,
                                          title: "Chungking Express",
                                          rating: "9.5/10.0 IMDb",
                                          genres: ["DRAMA", "FANTASY", "ADVENTURE","DRAMA", "FANTASY", "ADVENTURE"],
                                          duration: "1h 50m")
        
        popularMovies.append(chungkingExpress)
    }
}
