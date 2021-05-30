//
//  HomeMovieViewController.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import UIKit

class HomeMovieViewController: UIViewController {

    @IBOutlet private weak var tableViewMovie: UITableView!
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    
    private var viewModel = HomeMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.bind(view: self)
        getData()
    }
    
    func configureTableView(){
        tableViewMovie.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    private func getData(){
        viewModel.getListMoviesData()
    }
    
}


extension HomeMovieViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as!  MovieTableViewCell
        return cell
    }

}
