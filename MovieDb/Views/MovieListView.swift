//
//  MovieListView.swift
//  MovieDb
//
//  Created by Shubham Kumar on 28/07/24.
//
import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    @State private var searchText = ""
    @State private var expandedOption: String?
    @State private var isSearching = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(spacing: 0) {
                    SearchBar(text: $searchText,
                              placeholder: "Search movie by title/year/genre/directors/actors",
                              onSearchChanged: { newValue in
                        if newValue.isEmpty {
                            isSearching = false
                            viewModel.clearSearchResults()
                        } else {
                            isSearching = true
                            viewModel.searchMovies(query: newValue)
                        }
                    })
                    .frame(height: geometry.size.height * 0.15)
                    .padding(.bottom, geometry.size.height * -0.07) 
                    
                    if isSearching {
                        makeSearchResultsList(geometry: geometry)
                    } else {
                        makeCategoryList(geometry: geometry)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Movie Database")
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    @ViewBuilder
    private func makeSearchResultsList(geometry: GeometryProxy) -> some View {
        List(viewModel.searchResults) { movie in
            NavigationLink(destination: MovieDetailsView(movie: movie)) {
                MovieCell(movie: movie)
                    .frame(height: geometry.size.height * 0.15)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    @ViewBuilder
    private func makeCategoryList(geometry: GeometryProxy) -> some View {
        List {
            ForEach(viewModel.searchOptions, id: \.self) { option in
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { self.expandedOption == option },
                        set: { newValue in
                            if newValue {
                                self.expandedOption = option
                            } else {
                                self.expandedOption = nil
                            }
                        }
                    ),
                    content: {
                        ForEach(viewModel.getResults(for: option), id: \.self) { value in
                            if option == "All Movies" {
                                if let movie = viewModel.getMovie(for: value) {
                                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                        MovieCell(movie: movie)
                                            .frame(height: geometry.size.height * 0.15)
                                    }
                                }
                            } else {
                                NavigationLink(destination: MovieFilteredListView(viewModel: viewModel, searchOption: option, value: value)) {
                                    Text(value)
                                }
                            }
                        }
                    },
                    label: {
                        Text(option)
                    }
                )
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListViewModel())
    }
}
