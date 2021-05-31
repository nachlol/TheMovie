//
//  Movies.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import Foundation

struct Movies: Codable {
    let listOfmovies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case listOfmovies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let popularity: Double
    let genreID:[Int]
    let movieID: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let sinopsis: String
    let releaseDate: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case popularity
        case movieID = "id"
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case sinopsis = "overview"
        case releaseDate = "release_date"
        case image = "poster_path"
        case genreID = "genre_ids"
    }
}


struct CategoryMovie {
    let categoryName: String
    let movies: [Movie]
}
