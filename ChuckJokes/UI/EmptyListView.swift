//
//  EmptyListView.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import SwiftUI

struct  EmptyListView : View {
    
    var viewModel: RootViewModel
    
    var body: some View {
        VStack {
            Text("No Jokes Available :(").padding()
 
            Button("Fetch More Jokes!") {
                viewModel.fetchJokes()
            }.buttonStyle(FilledButton())
        }
    }
    
}

struct FilledButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(8)
    }
}
