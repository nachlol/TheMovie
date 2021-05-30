//
//  HomeMovieViewModel.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import Foundation

class HomeMovieViewModel {
    
    private var managerConnections = ManagerConnection()
    private(set) weak var view: HomeMovieViewController?
    
    func bind(view:HomeMovieViewController){
        self.view = view
    }
    
    
    func getListMoviesData() -> <#Return Type#>{
        return managerConnections.getPopularMovies()
    }
    
}
