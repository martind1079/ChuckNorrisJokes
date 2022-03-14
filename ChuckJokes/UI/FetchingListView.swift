//
//  FetchingListView.swift
//  ChuckNorrisJokes
//
//  Created by Martin Doyle on 12/03/2022.
//

import SwiftUI

struct  FetchingListView : View {
    
    var body: some View {
        VStack {
            Text("Fetching..").padding()
            ActivityIndicator(isAnimating: true).padding()
        }
    }
    
}
