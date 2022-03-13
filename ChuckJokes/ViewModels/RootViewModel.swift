//
//  RootViewModel.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation
import SwiftUI
import Combine

final class RootViewModel: ObservableObject {
    
    @Published var state : JokesListState = .empty
    
    @Published var  errorMessage : String = "" {
        didSet {
            hasError = errorMessage != ""
        }
    }
    
    @Published var hasError : Bool = false

    
    private (set) var apiService : APIService
    
    var subscriptions : Set<AnyCancellable> = []
    
    @Published var jokes : [JokeViewModel] = []
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchJokes() {
        errorMessage = ""
        state = .fetching
        apiService.fetchJokes()
            .sink(receiveCompletion: {
                
                [weak self] completion in
                
                switch completion {
                case .finished:
                    print("received response")
                case .failure(let error):
                    print("unable to fetch jokes")
                    self?.errorMessage = "Unable to fetch jokes. \(error.message)"
                    
                    self?.state = (self?.jokes.isEmpty ?? true) ? .empty : .presenting
                    
                }
                
            }, receiveValue: { [weak self] jokes in
                
                self?.jokes = jokes.map({
                    JokeViewModel(joke: $0)
                })
                self?.state = .presenting
                
            }).store(in: &subscriptions)
    }
    
}
