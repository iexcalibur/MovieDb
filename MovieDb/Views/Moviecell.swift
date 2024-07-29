//
//  Moviecell.swift
//  MovieDb
//
//  Created by Shubham Kumar on 28/07/24.
//
import SwiftUI

struct MovieCell: View {
    let movie: Movie
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 1)
                .cornerRadius(5)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(movie.title)
                        .font(.system(size: geometry.size.width * 0.05))
                        .fontWeight(.bold)
                        .lineLimit(2)
                    
                    HStack(spacing: 4) {
                        Text("Language:")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text(movie.language)
                    }
                    .font(.system(size: geometry.size.width * 0.045))
                    .foregroundColor(.secondary)
                    
                    HStack(spacing: 4) {
                        Text("Year:")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text(movie.year)
                    }
                    .font(.system(size: geometry.size.width * 0.045))
                    .foregroundColor(.secondary)
                }
                .frame(width: geometry.size.width * 0.7, alignment: .leading)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .padding(.vertical, 5)
        }
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(movie: Movie.sample)
            .frame(height: 100)  
    }
}
