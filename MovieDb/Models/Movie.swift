//
//  Movie.swift
//  MovieDb
//
//  Created by Shubham Kumar on 28/07/24.
//
import Foundation

struct Movie: Codable, Identifiable {
    let id: String
    let title: String
    let year: String
    let rated: String?
    let released: String?
    let runtime: String?
    let genre: String
    let director: String
    let writer: String?
    let actors: String
    let plot: String?
    let language: String
    let country: String?
    let awards: String?
    let poster: String
    let ratings: [Rating]
    let metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let type: String
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
    
    var posterURL: URL? {
        return URL(string: poster)
    }
}

struct Rating: Codable {
    let source: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
