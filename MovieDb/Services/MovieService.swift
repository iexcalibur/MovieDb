//
//  MovieService.swift
//  MovieDb
//
//  Created by Shubham Kumar on 28/07/24.
//

import Foundation

class MovieService {
    static func loadMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            completion([])
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let movies = try decoder.decode([Movie].self, from: data)
            completion(movies)
        } catch {
            print("Error loading movies: \(error)")
            completion([])
        }
    }
}
