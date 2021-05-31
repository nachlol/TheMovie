//
//  Languages.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 31/05/21.
//

import Foundation

// MARK: - Language
struct Language: Codable {
    let iso639_1, englishName, name: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case englishName = "english_name"
        case name
    }
}
