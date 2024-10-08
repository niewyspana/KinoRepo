//
//  APIManager.swift
//  Kino
//
//  Created by Viktoriya Polozova on 10/09/2024.
//

import Foundation

final class APIManager {
    
    static let apiKey = "48e14dcf-32d3-4445-ab41-884fab592329"
    static let baseUrl = "https://kinopoiskapiunofficial.tech/"
    
    static func configureRequest(_ cat: inout URLRequest) {
        cat.httpMethod = "GET"
        cat.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        cat.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    static func configureRequest(_ request: URLRequest) -> URLRequest {
        var request = request
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
