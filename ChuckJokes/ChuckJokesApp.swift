//
//  ChuckJokesApp.swift
//  ChuckJokes
//
//  Created by Martin Doyle on 13/03/2022.
//

import SwiftUI

@main
struct ChuckNorrisJokesApp: App {
    var body: some Scene {
        WindowGroup {
            let apiService = APIClient()
            let viewModel = RootViewModel(apiService: apiService)
            RootView(viewModel: viewModel)
        }
    }
}
