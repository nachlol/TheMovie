//
//  Constants.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import Foundation

struct Constants {
    static let apiKey = "?api_key=ef6ff3136707daddcea3f62e3516df43"
    
    struct URL {
        static let urlmain = "https://api.themoviedb.org/3"
        static let urlImage = "https://image.tmdb.org/t/p/w200"
        static let urlDetailMovie = ""
    }
    
    struct Movie {
        static let urlListMovie = "/movie/"
        static let urlGenre = "/genre/movie/list"
        static let urlLanguage = "/configuration/languages"
        static let urlDiscover = "/discover/movie"
        static let urlSearch = "/search/movie"
    }
}
