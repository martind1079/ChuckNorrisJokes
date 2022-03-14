//
//  APIError.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation

enum ApiError : Error {
    
    case failedRequest
    case invalidResponse
    case unknown
    case unreachable
    
    var message: String {
            switch self {
            case .unreachable:
                return "You need to have a network connection."
            case .unknown,
                 .failedRequest,
                 .invalidResponse:
                return "The list of episodes could not be fetched."
            }
        }
}
