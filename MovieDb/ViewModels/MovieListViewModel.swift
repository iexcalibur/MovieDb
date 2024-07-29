//
//  MovieListViewModel.swift
//  MovieDb
//
//  Created by Shubham Kumar on 28/07/24.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchResults: [Movie] = []
    let searchOptions = ["Year", "Genre", "Directors", "Actors", "All Movies"]
    
    init() {
        fetchMovies()
    }
    
    private func fetchMovies() {
        MovieService.loadMovies { [weak self] movies in
            DispatchQueue.main.async {
                self?.movies = movies
            }
        }
    }
    
    func getResults(for searchOption: String) -> [String] {
        switch searchOption {
        case "Year":
            return Array(Set(movies.map { $0.year })).sorted()
        case "Genre":
            return Array(Set(movies.flatMap { $0.genre.components(separatedBy: ",") }
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }))
                .sorted()
        case "Directors":
            return Array(Set(movies.map { $0.director })).sorted()
        case "Actors":
            return Array(Set(movies.flatMap { $0.actors.components(separatedBy: ", ") })).sorted()
        case "All Movies":
            return Array(Set(movies.map { $0.title })).sorted()
        default:
            return []
        }
    }
    func movies(for searchOption: String, value: String) -> [Movie] {
        switch searchOption {
        case "Year":
            return movies.filter { $0.year == value }
        case "Genre":
            return movies.filter { movie in
                movie.genre.components(separatedBy: ",")
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .contains(value)
            }
        case "Directors":
            return movies.filter { $0.director == value }
        case "Actors":
            return movies.filter { $0.actors.contains(value) }
        case "All Movies":
            return movies.filter { $0.title == value }
        default:
            return []
        }
    }
    
    func getMovie(for title: String) -> Movie? {
        return movies.first { $0.title == title }
    }
    
    func searchMovies(query: String) {
            let lowercasedQuery = query.lowercased()
            searchResults = movies.filter { movie in
                movie.title.lowercased().contains(lowercasedQuery) ||
                movie.genre.lowercased().contains(lowercasedQuery) ||
                movie.director.lowercased().contains(lowercasedQuery) ||
                movie.actors.lowercased().contains(lowercasedQuery) ||
                movie.year.lowercased().contains(lowercasedQuery) ||
                movie.language.lowercased().contains(lowercasedQuery)
            }
        }
        
        func clearSearchResults() {
            searchResults = []
        }
}



