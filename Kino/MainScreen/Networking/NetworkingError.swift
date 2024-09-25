//
//  NetworkingError.swift
//  Kino
//
//  Created by Viktoriya Polozova on 10/09/2024.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
    case invalidURL
    case quotaExceeded
    case serverError(statusCode: Int, data: Data?)
}
