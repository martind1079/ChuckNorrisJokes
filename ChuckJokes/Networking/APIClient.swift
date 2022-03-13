//
//  APIClient.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation
import Combine

class APIClient : APIService {
    
    func fetchJokes() -> AnyPublisher<[Joke], ApiError> {
        
        return URLSession.shared.dataTaskPublisher(for: Environment.jokesURL)
            .retry(1)
            .tryMap({
                data, response -> [Joke] in
                guard  let response = response as? HTTPURLResponse,
                       (200..<300).contains(response.statusCode) else {
                           throw ApiError.failedRequest
                       }
                do {
                    
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    guard apiResponse.type == "success", let jokes = apiResponse.value else {
                        
                        throw ApiError.invalidResponse
                    }
                    
                    return jokes.filter({
                        $0.isExplicit() == false
                    })
                    
                } catch (let error) {
                    print("unable to decode : \(error)")
                    throw ApiError.invalidResponse
                }
            })
            .mapError({
                error -> ApiError in
                switch error {
                case let apiError as ApiError:
                    return apiError
                case URLError.notConnectedToInternet:
                    return ApiError.unreachable
                default:
                    return ApiError.failedRequest
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            
    }
    
    
}
