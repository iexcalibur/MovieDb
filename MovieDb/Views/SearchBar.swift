//
//  SearchBar.swift
//  MovieDb
//
//  Created by Shubham Kumar on 29/07/24.
//


import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    var onSearchChanged: (String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                TextField(placeholder, text: $text, onEditingChanged: { _ in
                    onSearchChanged(text)
                })
                .onChange(of: text) { oldValue, newValue in
                    onSearchChanged(newValue)
                }
                .padding(geometry.size.height * 0.1)
                .padding(.horizontal, geometry.size.width * 0.06)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, geometry.size.width * 0.04)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                                onSearchChanged("")
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, geometry.size.width * 0.04)
                            }
                        }
                    }
                )
                .font(.system(size: min(geometry.size.width * 0.04, 16)))
            }
            .padding(.horizontal, geometry.size.width * 0.04)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBar(text: .constant(""),
                      placeholder: "Search movie by title/year/genre/directors/actors",
                      onSearchChanged: { _ in })
                .previewDisplayName("Empty Search")
            
            SearchBar(text: .constant("Movie"),
                      placeholder: "Search movie by title/year/genre/directors/actors",
                      onSearchChanged: { _ in })
                .previewDisplayName("With Search Text")
        }
        .previewLayout(.sizeThatFits)
        .frame(height: 150) 
        .padding()
        .background(Color.white)
    }
}
