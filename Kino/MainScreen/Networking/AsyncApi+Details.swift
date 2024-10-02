//
//  AsyncApi+Details.swift
//  Kino
//
//  Created by Viktoriya Polozova on 01/10/2024.
//

import Foundation

extension APIManager {
    
    static func fetchDetailsMovie(movieId: Int) async throws -> Result<MovieDetailedInfoResponce, Error> {
        let stringUrl = baseUrl + "api/v2.2/films/" + "\(movieId)"
        guard let url = URL(string: stringUrl)
        else { return .failure(NetworkingError.invalidURL) }
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        return try await handleDetailsResponse(data: data)
    }
    
    private static func handleDetailsResponse(data: Data?) async throws -> Result<MovieDetailedInfoResponce, Error> {
        if let data = data {
            do {
                let response = try JSONDecoder().decode(MovieDetailedInfoResponce.self, from: data)
                return .success(response)
            } catch let decodeError {
                return .failure(decodeError)
            }
        } else {
            return .failure(NetworkingError.emptyData)
        }
    }
    
    static func fetchCast(movieId: Int) async throws -> Result<[ActorResponse], Error> {
        let stringUrl = baseUrl + "api/v1/staff" + "?filmId=\(movieId)"
        
        guard let url = URL(string: stringUrl)
        else { return .failure(NetworkingError.invalidURL) }
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        return try await handleActorResponse(data: data)
    }
    
    private static func handleActorResponse(data: Data?) async throws -> Result<[ActorResponse], Error> {
        if let data = data {
            do {
                let response = try JSONDecoder().decode([ActorResponse].self, from: data)
                return .success(response)
            } catch let decodeError {
                return .failure(decodeError)
            }
        } else {
            return .failure(NetworkingError.emptyData)
        }
    }
}
