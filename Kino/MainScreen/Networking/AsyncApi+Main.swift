//
//  AsyncApi+Main.swift
//  Kino
//
//  Created by Viktoriya Polozova on 01/10/2024.
//

import Foundation

extension APIManager {
    
    static func fetchPopularMovies(page: Int) async throws -> Result<[PopularMovie], Error> {
        let stringUrl = baseUrl + "api/v2.2/films/collections" + "?type=TOP_POPULAR_MOVIES&page=\(page)"
        guard let url = URL(string: stringUrl) else { return .failure(NetworkingError.invalidURL) }
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        return try await handlePopularMoviesResponse(data: data)
    }
    
    private static func handlePopularMoviesResponse(data: Data?) async throws -> Result<[PopularMovie], Error> {
        if let data = data {
            do {
                let response = try JSONDecoder().decode(PopularMoviesResponse.self, from: data)
                return .success(response.items)
            } catch let decodeError {
                return .failure(decodeError)
            }
        } else {
            return .failure(NetworkingError.unknown)
        }
    }
    
    static func fetchNowShowingMovies() async throws -> Result<[NowShowingMovie], Error> {
        
        let date = Date()
        
        let currentYear = Calendar.current.component(.year, from: date)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM"
        let currentMonth = dateFormatter.string(from: date).uppercased()
        
        let stringUrl = baseUrl + "api/v2.2/films/premieres" + "?year=\(currentYear)&month=\(currentMonth)"
        
        guard let url = URL(string: stringUrl)
        else { return .failure(NetworkingError.invalidURL)}
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        return try await handleNowShowingResponse(data: data)
    }
    
    private static func handleNowShowingResponse(data: Data?) async throws -> Result<[NowShowingMovie], Error>{
        if let data = data {
            do {
                let movieInfo = try JSONDecoder().decode(NowShowingMoviesResponse.self, from: data)
                return .success(movieInfo.items)
            } catch let decodeError {
                return .failure(decodeError)
            }
        } else {
            return .failure(NetworkingError.unknown)
        }
    }
    
    static func fetchNowShowingMoviesWithRatings() async throws -> Result<[NowShowingMovie], Error> {
        let nowShowingResult = try await fetchNowShowingMovies()
        
        switch nowShowingResult {
        case .success(let movies):
            var moviesWithRatings: [NowShowingMovie] = []
            
            try await withThrowingTaskGroup(of: NowShowingMovie?.self) { group in
                for movie in movies {
                    // add group task
                    group.addTask {
                        do {
                            // ask for details
                            let detailsResult = try await fetchDetailsMovie(movieId: movie.id)
                            
                            // handle the result of details
                            switch detailsResult {
                            case .success(let detailedInfo):
                                // load rating for films
                                var movieWithRating = movie
                                movieWithRating.imdbRating = detailedInfo.imdbRating
                                return movieWithRating
                                
                            case .failure:
                                // return film without rating
                                return movie
                            }
                        } catch {
                            return nil
                        }
                    }
                }
                for try await movieWithRating in group {
                    if let movie = movieWithRating {
                        moviesWithRatings.append(movie)
                    }
                }
            }
            return .success(moviesWithRatings)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func fetchPopularMoviesWithDuration(page: Int) async throws -> Result<[PopularMovie], Error> {
        // fetch the list of popular movies
        let popularMoviesResult = try await fetchPopularMovies(page: page)
        
        // handle the result of the popular movies fetch
        switch popularMoviesResult {
        case .success(let movies):
            var moviesWithDuration: [PopularMovie] = []
            
            // use Task Group to concurrently fetch the details of each movie
            try await withThrowingTaskGroup(of: PopularMovie?.self) { group in
                for movie in movies {
                    // add a task to fetch movie details
                    group.addTask {
                        do {
                            // fetch movie details
                            let detailsResult = try await fetchDetailsMovie(movieId: movie.id)
                            
                            // process the result of the movie details fetch
                            switch detailsResult {
                            case .success(let detailedInfo):
                                // update movie with its duration
                                var movieWithDuration = movie
                                movieWithDuration.duration = detailedInfo.duration
                                return movieWithDuration
                            case .failure:
                                // return the original movie without the duration
                                return movie
                            }
                        } catch {
                            return nil
                        }
                    }
                }
                
                // collect results from all tasks
                for try await movieWithDuration in group {
                    if let movie = movieWithDuration {
                        moviesWithDuration.append(movie)
                    }
                }
            }
            
            return .success(moviesWithDuration)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}
