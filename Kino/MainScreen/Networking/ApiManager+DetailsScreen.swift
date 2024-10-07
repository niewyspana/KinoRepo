//
//  ApiManager+DetailsScreen.swift
//  Kino
//
//  Created by Viktoriya Polozova on 19/09/2024.
//

import Foundation

extension APIManager {
    
    // create url path and make request
    
    static func fetchDetailsMovie(movieId: Int, completion: @escaping (Result<MovieDetailedInfoResponce, Error>) -> ()) {
        let stringUrl = baseUrl + "api/v2.2/films/" + "\(movieId)"
        guard let url = URL(string: stringUrl) else { return }
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            handleDetailsResponse(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    // handle response
    
    private static func handleDetailsResponse(data: Data?, error: Error?, completion: @escaping (Result<MovieDetailedInfoResponce, Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                let response = try JSONDecoder().decode(MovieDetailedInfoResponce.self, from: data)
                completion(.success(response))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
    
    static func fetchCast(movieId: Int, completion: @escaping (Result<[ActorResponse], Error>) -> ()) {
        let stringUrl = baseUrl + "api/v1/staff" + "?filmId=" + "\(movieId)"
        guard let url = URL(string: stringUrl) else { return }
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            handleActorResponse(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    private static func handleActorResponse(data: Data?, error: Error?, completion: @escaping (Result<[ActorResponse], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                let response = try JSONDecoder().decode([ActorResponse].self, from: data)
                completion(.success(response))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
