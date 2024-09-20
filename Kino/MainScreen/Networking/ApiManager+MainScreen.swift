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
}
