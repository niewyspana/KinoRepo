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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genreLabel.layer.cornerRadius = 8
        genreLabel.layer.masksToBounds = true
        genreLabel.backgroundColor = .blue
        genreLabel.textColor = .white
        genreLabel.textAlignment = .center
    }
    
    public func configure(with genre: String) {
        genreLabel.text = genre
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
