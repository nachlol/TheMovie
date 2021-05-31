//
//  HomeMovieViewModel.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import Foundation
import RxSwift

class HomeMovieViewModel {
    
    private var managerConnections = ManagerConnection()
    private(set) weak var view: HomeMovieViewController?
    
    func bind(view:HomeMovieViewController){
        self.view = view
    }
    
    func getListMoviesData(type:String) -> Observable<[Movie]>{
        return managerConnections.getMovies(type: type)
    }
    
    func getListGenreData() -> Observable<[Genre]>{
        return managerConnections.getGenres()
    }
    
    func getListLanguageData() -> Observable<[Language]>{
        return managerConnections.getLanguage()
    }
    
    func getDiscoverData(language:String,voteAverageMin:Int,voteAverageMax:Int,includeAdult:Bool) -> Observable<[Movie]>{
        return managerConnections.getDiscover(language: language, voteAverageMin: voteAverageMin, voteAverageMax: voteAverageMax, includeAdult: includeAdult)
    }
    
    func getSearchData(search:String) -> Observable<[Movie]>{
        return managerConnections.getSearch(search: search)
    }
}
