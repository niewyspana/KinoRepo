//
//  Data+Json.swift
//  Kino
//
//  Created by Viktoriya Polozova on 19/09/2024.
//

import Foundation

extension Data {
    func toJsonString() -> String? {
        if let jsonString = String(data: self, encoding: .utf8) {
            print(jsonString)
            return jsonString
        } else {
            print("Failed to convert JSON data to string.")
            return nil
        }
    }
}
