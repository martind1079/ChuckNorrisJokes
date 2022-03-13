//
//  JokeViewModel.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation

class JokeViewModel: Identifiable {
    
    var joke : Joke?
    
    init(joke: Joke) {
        self.joke = joke
    }
    
    init() {
        
    }
    
    var formattedDescription : String {
        return formatJoke(joke?.jokeDescription ?? "")
    }
    
    func formatJoke(_ jokeDescription: String) -> String {
        
        return removeSpecialCharacters(jokeDescription)
        
    }
    
    func removeSpecialCharacters(_ string: String) -> String {

        return string.replacingOccurrences(of: "&quot;", with: "'")
            .replacingOccurrences(of: "&apos;", with: "'")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
    }
    
}
