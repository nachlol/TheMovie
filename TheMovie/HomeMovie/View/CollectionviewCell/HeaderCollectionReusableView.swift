//
//  HeaderCollectionReusableView.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 31/05/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var lblTitleGenre: UILabel!
    
    static let identifier = "HeaderCollectionReusable"
    
    static func nib() -> UINib {
        return UINib(nibName: "HeaderCollectionReusableView", bundle: nil)
    }
    
}
