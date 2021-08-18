//
//  APIErrors.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 18/08/21.
//

import Foundation


/// API related errors
enum APIError: Error {
    case invalidURL
    case requestError(Error)
    case noData
}

