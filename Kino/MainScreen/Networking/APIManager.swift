//
//  APIManager.swift
//  Kino
//
//  Created by Viktoriya Polozova on 10/09/2024.
//

import Foundation

final class APIManager {
    
    private static let apiKey = "48e14dcf-32d3-4445-ab41-884fab592329"
    private static let baseUrl = "https://kinopoiskapiunofficial.tech/documentation/"
    private static let path = "api/#/films/get_api_v2_2_films__id_"
    
    // create url path and make request
    
    static func getMoviews(completion: @escaping (Result <[MovieInfo], Error>) -> ()) {
        let stringUrl = baseUrl + path + apiKey
        guard let url = URL(string: stringUrl) else { return }
        let session = URLSession.shared.dataTask(with: url) {data, response,
            error in
            handleResponse(data: data, error: error)
        }
        session.resume()
    }
    
    // handle response
    private static func handleResponse(data: Data?, error: Error?) {
        
    }
}
