//
//  MovieListResultView.swift
//  MovieDb
//
//  Created by Shubham Kumar on 28/07/24.
//

import SwiftUI

struct MovieListResultView: View {
    @ObservedObject var viewModel: MovieListViewModel
    let searchOption: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(viewModel.getResults(for: searchOption), id: \.self) { value in
                    NavigationLink(destination: MovieFilteredListView(viewModel: viewModel, searchOption: searchOption, value: value)) {
                        if searchOption == "All Movies" {
                            if let movie = viewModel.getMovie(for: value) {
                                MovieCell(movie: movie)
                                    .frame(height: geometry.size.height * 0.15)
                            } else {
                                Text(value)
                            }
                        } else {
                            Text(value)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            makeToolbar()
        }
    }

    @ToolbarContentBuilder
    private func makeToolbar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
            }
        }
    }
}




