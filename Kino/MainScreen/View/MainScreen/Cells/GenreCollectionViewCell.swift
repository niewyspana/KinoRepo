//
//  GenreCollectionViewCell.swift
//  Kino
//
//  Created by Viktoriya Polozova on 20/08/2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GenreCollectionViewCell"
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedView.layer.cornerRadius = roundedView.frame.height / 2
        roundedView.layer.masksToBounds = true
    }
    
    public func configure(with genre: String) {
        genreLabel.text = genre
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
