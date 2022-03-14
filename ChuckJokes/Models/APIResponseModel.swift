//
//  APIResponseModel.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation

struct APIResponse : Decodable {
    
    var type : String
    var value : [Joke]?

}
