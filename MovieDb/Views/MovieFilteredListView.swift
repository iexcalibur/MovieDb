//
//  MovieFilteredListView.swift
//  MovieDb
//
//  Created by Shubham Kumar on 29/07/24.
//

import SwiftUI

struct MovieFilteredListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    let searchOption: String
    let value: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            List(viewModel.movies(for: searchOption, value: value)) { movie in
                NavigationLink(destination: MovieDetailsView(movie: movie)) {
                    MovieCell(movie: movie)
                        .frame(height: geometry.size.height * 0.15)
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
