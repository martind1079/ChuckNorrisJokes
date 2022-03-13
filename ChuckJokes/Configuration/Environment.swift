//
//  Environment.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation

enum Environment {
    
    static var jokesURL: URL {
        URL(string: "https://api.icndb.com/jokes/random/\(numberOfJokes)")!
    }
    
    static var numberOfJokes : Int {
        5
    }
    
}
