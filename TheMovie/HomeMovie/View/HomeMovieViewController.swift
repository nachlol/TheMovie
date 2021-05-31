//
//  HomeMovieViewController.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeMovieViewController: UIViewController {

    @IBOutlet private weak var collectionviewMovie: UICollectionView!
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var imgFilter: UIImageView!
    
    private var viewModel = HomeMovieViewModel()
    
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    private var languages = [Language]()
    private let disposeBag = DisposeBag()
    private var filterview: FilterView?
    private var priceRangeStart = 0
    private var priceRangeEnd = 0
    private var maxHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureFilter()
        viewModel.bind(view: self)
        configureSegment()
        getGenres()
        getLanguages()
    }
    
    //MARK: - Services
    
    private func getDatMovies(type:String){
        return viewModel.getListMoviesData(type: type)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { movies in
                        self.movies = movies
                        self.reloadTableView()
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    private func getGenres(){
        return viewModel.getListGenreData()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { genres in
                    print(genres)
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    private func getLanguages(){
        return viewModel.getListLanguageData()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { languages in
                    self.languages = languages
                    self.languages.sort { (languageOne, languageTwo) -> Bool in
                        languageOne.englishName < languageTwo.englishName
                    }
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    private func getFindDiscover(language:String,includeAdult:Bool){
        return viewModel.getDiscoverData(language: language, voteAverageMin: self.priceRangeStart, voteAverageMax: self.priceRangeEnd, includeAdult: includeAdult)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { movies in
                    print(movies)
                    self.movies = movies
                    self.reloadTableView()
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Functions
    
    private func configureCollectionView(){
        collectionviewMovie.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    private func configureSegment(){
        //Change Background Color
        segmentControl.backgroundColor = UIColor.init(named: "ColorBackground")
        segmentControl.layer.borderColor = UIColor.white.cgColor
        segmentControl.selectedSegmentTintColor = UIColor.white
        segmentControl.layer.borderWidth = 1

        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentControl.setTitleTextAttributes(titleTextAttributes, for:.normal)

        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor:  UIColor.init(named: "ColorBackground")]
        segmentControl.setTitleTextAttributes(titleTextAttributes1 as [NSAttributedString.Key : Any], for:.selected)
        
        //Load Info Movies
        segmentControl.addTarget(self, action: #selector(actionSegmentControl), for: .valueChanged)
        if segmentControl.selectedSegmentIndex == 0 {
            getDatMovies(type: "popular")
        }else if segmentControl.selectedSegmentIndex == 1 {
            getDatMovies(type: "top_rated")
        }
    }
    
    func setFilterVotedRange() {
        self.priceRangeStart = Int((self.filterview?.rangeBarVoted.selectedMinValue)!)
        self.priceRangeEnd = Int((self.filterview?.rangeBarVoted.selectedMaxValue)!)

        self.filterview?.lblFilterVotedMin.text = String(Int((self.filterview?.rangeBarVoted.selectedMinValue)!))
        self.filterview?.lblFilterVotedMax.text = String(Int((self.filterview?.rangeBarVoted.selectedMaxValue)!))
    }
    
    func actionApplyFilter(view:FilterView){
        getFindDiscover(language: view.selectLanguage, includeAdult: view.includeAdult)
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.collectionviewMovie.reloadData()
        }
    }
    
    private func configureFilter(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleFilter))
        imgFilter.addGestureRecognizer(tapGestureRecognizer)
        imgFilter.isUserInteractionEnabled = true
    }
    
    private func converDate(date:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrintToday = DateFormatter()
        dateFormatterPrintToday.dateFormat = "MMM dd,yyyy"
    
        if let dateConvert = dateFormatterGet.date(from: date) {
            return dateFormatterPrintToday.string(from: dateConvert)
        } else {
           print("There was an error decoding the string")
           return ""
        }
    }
    
    //MARK: - Objc
    
    @objc func actionSegmentControl(){
        if segmentControl.selectedSegmentIndex == 0 {
            getDatMovies(type: "popular")
        }else if segmentControl.selectedSegmentIndex == 1 {
            getDatMovies(type: "top_rated")
        }
    }
    
    @objc func handleFilter()
    {
        self.filterview = FilterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.filterview?.rangeBarVoted.delegate = self
        self.filterview?.viewController = self
        self.filterview?.rangeBarVoted.minValue = 0
        self.filterview?.rangeBarVoted.maxValue = 10
        self.filterview?.language = self.languages
        setFilterVotedRange()
        self.view.addSubview(self.filterview ?? UIView())
    }
}

//MARK: - Extension RangeSeekSliderDelegate

extension HomeMovieViewController: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        //Change price range
        if slider === filterview?.rangeBarVoted {
            self.setFilterVotedRange()
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HomeMovieViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as!  MovieCollectionViewCell
        cell.layer.applySketchShadow(color: UIColor.black.withAlphaComponent(0.3),x:0,y: 3,blur: 6)
        cell.layer.masksToBounds = false
        if let image = self.movies[indexPath.row].image {
            cell.imgMovie.imageFromServerURL(urlString: "\(Constants.URL.urlImage+image)", placeHolderImage: UIImage(named: "icon_logo")!)
        }
        cell.lbltitleMovie.text = self.movies[indexPath.row].title
        cell.lblDateMovie.text = converDate(date: self.movies[indexPath.row].releaseDate ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = (self.view.bounds.width / 2.0) - 40.0
        return CGSize(width: screenWidth, height: 350)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
