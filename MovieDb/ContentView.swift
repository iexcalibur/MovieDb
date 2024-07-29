//
//  ContentView.swift
//  MovieDb
//
//  Created by Shubham Kumar on 28/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var movieListViewModel = MovieListViewModel()
    
    var body: some View {
        MovieListView(viewModel: movieListViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
