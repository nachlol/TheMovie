//
//  MovieCollectionViewCell.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 31/05/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var lbltitleMovie:UILabel!
    @IBOutlet weak var lblDateMovie:UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    static let identifier = "MovieCollectionviewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadows()
    }
    
    func configureShadows(){
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.systemGray5.cgColor
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
}
