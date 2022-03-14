//
//  JokesListView.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//


import SwiftUI

struct  JokesListView : View {
    
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        
        Text("Your Jokes :)").font(.title).padding()
        Text("refresh list for more jokes").foregroundColor(.gray).font(.system(size: 10))
        List {
            ForEach(viewModel.jokes) {
                jokeVM in
                
                Text(jokeVM.formattedDescription).font(.system(size: 13)).padding()
                
            }
        }.listStyle(.plain).refreshable {
            viewModel.fetchJokes()
        }.padding()
        .cornerRadius(7)
            
        
        
    }
    
}
