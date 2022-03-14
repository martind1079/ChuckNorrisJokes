//
//  APIService.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation
import Combine

protocol APIService {
    
    func fetchJokes() -> AnyPublisher<[Joke], ApiError>
    
}
