//
//  MovieTableViewCell.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableviewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
