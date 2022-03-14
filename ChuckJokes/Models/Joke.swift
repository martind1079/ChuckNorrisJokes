//
//  Joke.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation

struct Joke: Decodable {
    
    var jokeId : Int
    var jokeDescription : String
    var categories : [String]
    
   enum codingKeys: String, CodingKey {
        case jokeId = "id"
        case jokeDescription = "joke"
        case categories
    }
    
     init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: codingKeys.self)
         
        var jokeId: Int = 0;  do { jokeId = try container.decode(Int.self, forKey: .jokeId) } catch { throw DecodingError.failedToDecode }
         var jokeDescription: String = "";  do { jokeDescription = try container.decode(String.self, forKey: .jokeDescription) } catch { throw DecodingError.failedToDecode }
        var categories: [String] = [];  do { categories = try container.decode([String].self, forKey: .categories) } catch { throw DecodingError.failedToDecode }
        
        self.jokeId = jokeId
        self.jokeDescription = jokeDescription
        self.categories = categories
        
    }
    
    func isExplicit() -> Bool {
        return categories.filter({
            $0 == "explicit"
        }).count > 0
    }
    
}


enum DecodingError : Error {
    case failedToDecode
    
    var message : String {
        switch self {
        default :
            return "Failed to decode Joke"
        }
    }
}



