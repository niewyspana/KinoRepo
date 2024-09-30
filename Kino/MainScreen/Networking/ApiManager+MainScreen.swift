//
//  ApiManager+MainScreen.swift
//  Kino
//
//  Created by Viktoriya Polozova on 19/09/2024.
//

import Foundation

extension APIManager {
    static func fetchNowShowingMovies(completion: @escaping (Result<[NowShowingMovie], Error>) -> ()) {
        
        let date = Date()
        
        let currentYear = Calendar.current.component(.year, from: date)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM"
        let currentMonth = dateFormatter.string(from: date).uppercased()
        
        let stringUrl = baseUrl + "api/v2.2/films/premieres" + "?year=\(currentYear)&month=\(currentMonth)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            handleNowShowingResponse(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    static func fetchPopularMovies(page: Int, completion: @escaping (Result<[PopularMovie], Error>) -> ()) {
        let stringUrl = baseUrl + "api/v2.2/films/collections" + "?type=TOP_POPULAR_MOVIES&page=\(page)"
        guard let url = URL(string: stringUrl) else { return }
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            handlePopularMoviesResponse(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    private static func handleNowShowingResponse(data: Data?, error: Error?, completion: @escaping (Result<[NowShowingMovie], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                let movieInfo = try JSONDecoder().decode(NowShowingMoviesResponse.self, from: data)
                completion(.success(movieInfo.items))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
    
    private static func handlePopularMoviesResponse(data: Data?, error: Error?, completion: @escaping (Result<[PopularMovie], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                let response = try JSONDecoder().decode(PopularMoviesResponse.self, from: data)
                completion(.success(response.items))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
    
    static func fetchNowShowingMoviesWithRatings(completion: @escaping (Result<[NowShowingMovie], Error>) -> ()) {
        fetchNowShowingMovies { result in
            switch result {
            case .success(let movies):
                var moviesWithRatings: [NowShowingMovie] = []
                let dispatchGroup = DispatchGroup()
                
                // create semaphore to control the number of concurrent tasks
                let semaphore = DispatchSemaphore(value: 5)
                
                for movie in movies {
                    dispatchGroup.enter()
                    print("task for movie \(movie.id) is waiting for semaphore...")
                    
                    semaphore.wait()
                    
                    print("task for movie \(movie.id) acquired the semaphore.")
                    
                    fetchDetailsMovie(movieId: movie.id) { detailsResult in
                        switch detailsResult {
                        case .success(let detailedInfo):
                            var movieWithRating = movie
                            movieWithRating.imdbRating = detailedInfo.imdbRating
                            moviesWithRatings.append(movieWithRating)
                            
                            // Release the semaphore
                            semaphore.signal()
                            print("task for movie \(movie.id) released the semaphore.")
                            
                            dispatchGroup.leave()
                            
                        case .failure(let error):
            
                            semaphore.signal()
                            dispatchGroup.leave()
                            
                            if let urlError = error as? URLError, urlError.code == .badServerResponse {
                                completion(.success(movies))
                                return
                            }
                            
                            if let networkingError = error as? NetworkingError {
                                switch networkingError {
                                case .serverError(_, let data):
                                    if let data = data,
                                       let responseBody = String(data: data, encoding: .utf8),
                                       responseBody.contains("You exceeded the quota") {
                                        completion(.success(movies))
                                        return
                                    } else {
                                        completion(.failure(error))
                                        return
                                    }
                                default:
                                    completion(.failure(error))
                                    return
                                }
                            } else {
                                completion(.failure(error))
                            }
                        }
                    }
                }
                
                // Notify after all tasks are completed
                dispatchGroup.notify(queue: .main) {
                    print("all tasks completed.")
                    completion(.success(moviesWithRatings))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
 
    static func fetchPopularMoviesWithDuration(page: Int, completion: @escaping (Result<[PopularMovie], Error>) -> ()) {
        fetchPopularMovies(page: page) { result in
            switch result {
            case .success(let movies):
                var moviesWithDuration: [PopularMovie] = []
                let dispatchGroup = DispatchGroup()
                
                for movie in movies {
                    dispatchGroup.enter()
                    
                    fetchDetailsMovie(movieId: movie.id) { detailsResult in
                        switch detailsResult {
                        case .success(let detailedInfo):
                            var movieWithDuration = movie
                            movieWithDuration.duration = detailedInfo.duration
                            moviesWithDuration.append(movieWithDuration)
                        case .failure(let error):
                            if let urlError = error as? URLError {
                                if urlError.code == .badServerResponse {
                                    completion(.success(movies))
                                    dispatchGroup.leave()
                                    return
                                } else {
                                    completion(.failure(error))
                                    dispatchGroup.leave()
                                    return
                                }
                            }
                            if let networkingError = error as? NetworkingError {
                                switch networkingError {
                                case .serverError(_, let data):
                                    if let data = data,
                                       let responseBody = String(data: data, encoding: .utf8),
                                       responseBody.contains("You exceeded the quota") {
                                        completion(.success(movies))
                                        dispatchGroup.leave()
                                        return
                                    } else {
                                        completion(.failure(error))
                                        dispatchGroup.leave()
                                        return
                                    }
                                default:
                                    completion(.failure(error))
                                    dispatchGroup.leave()
                                    return
                                }
                            } else {
                                completion(.failure(error))
                            }
                        }
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    completion(.success(moviesWithDuration))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
