//
//  RootView.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import Foundation

import SwiftUI

struct RootView: View {
    
    @ObservedObject var viewModel : RootViewModel
    
    var body: some View {
        
        VStack {
            switch viewModel.state {
            case .empty:
                
              EmptyListView(viewModel: viewModel)
                
            case .fetchNew:
                
               FetchingListView()
                    
            case .presenting:
                
                JokesListView(viewModel: viewModel)
                
            }
        }.onAppear(perform: {
            
            viewModel.fetchJokes()
            
        }).alert(isPresented: $viewModel.hasError, content: {
            Alert(title: Text(viewModel.errorMessage))
        }).multilineTextAlignment(.center)
            
        
        
    }
}

struct JokesListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RootViewModel(apiService: APIClient())
        RootView(viewModel: viewModel)
    }
}



