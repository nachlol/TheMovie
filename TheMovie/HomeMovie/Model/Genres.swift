//
//  Genre.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import Foundation

// MARK: - ListGenres
struct ListGenres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
