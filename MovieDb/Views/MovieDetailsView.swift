//
//  MovieDetailsView.swift
//  MovieDb
//
//  Created by Shubham Kumar on 28/07/24.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @Environment(\.presentationMode) var presentationMode
    @State private var showingRatingPicker = false
    @State private var selectedRatingSource = "Internet Movie Database"
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            AsyncImage(url: URL(string: movie.poster)) { image in
                                image.resizable().aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                            .clipped()
                            
                        }
                    }
                    .frame(height: geometry.size.height * 0.6)
                    .scrollTargetLayout()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                                Text(movie.title)
                                    .font(.title2).bold()
                                Spacer()
                                Text(movie.year)
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack {
                                Text(movie.genre)
                                if let runtime = movie.runtime {
                                    Text("•")
                                    Text(runtime)
                                }
                            }
                            .foregroundColor(.secondary)

                        
                        if let plot = movie.plot {
                            Text(plot)
                                .font(.body)
                                .lineLimit(3)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Cast")
                                .font(.headline)
                            
                            Text(movie.actors)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Rating:")
                                .font(.headline)
                            if let rating = movie.ratings.first(where: { $0.source == selectedRatingSource }) {
                                Text(rating.value)
                            }
                            Spacer()
                            Button(action: {
                                showingRatingPicker = true
                            }) {
                                Image(systemName: "chevron.down")
                            }
                        }
                        .padding(.vertical, 5)
                        .actionSheet(isPresented: $showingRatingPicker) {
                            ActionSheet(title: Text("Ratings"), buttons:
                                movie.ratings.map { rating in
                                    .default(Text(rating.source)) {
                                        selectedRatingSource = rating.source
                                    }
                                } + [.cancel()]
                            )
                        }
                        
                        Text("Audio Track: \(movie.language)")
                            .foregroundColor(.secondary)
                            .padding(.top)
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailsView(movie: Movie.sample)
        }
    }
}
extension Movie {
    static let sample = Movie(
        id: "tt0111161",
        title: "The Shawshank Redemption",
        year: "1994",
        rated: "R",
        released: "14 Oct 1994",
        runtime: "142 min",
        genre: "Drama",
        director: "Frank Darabont",
        writer: "Stephen King, Frank Darabont",
        actors: "Tim Robbins, Morgan Freeman, Bob Gunton",
        plot: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
        language: "English",
        country: "USA",
        awards: "Nominated for 7 Oscars. Another 21 wins & 43 nominations.",
        poster: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
        ratings: [
            Rating(source: "Internet Movie Database", value: "9.3/10"),
            Rating(source: "Rotten Tomatoes", value: "91%"),
            Rating(source: "Metacritic", value: "80/100")
        ],
        metascore: "80",
        imdbRating: "9.3",
        imdbVotes: "2,405,283",
        type: "movie",
        dvd: "27 Jan 1998",
        boxOffice: "$28,699,976",
        production: "Columbia Pictures, Castle Rock Entertainment",
        website: "N/A",
        response: "True"
    )
}
