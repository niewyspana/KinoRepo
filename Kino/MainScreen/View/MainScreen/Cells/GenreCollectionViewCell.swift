//
//  GenreCollectionViewCell.swift
//  Kino
//
//  Created by Viktoriya Polozova on 20/08/2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedView.layoutIfNeeded()
        roundedView.layer.cornerRadius = roundedView.frame.height / 2
    }
    
    public func configure(with genre: String) {
        genreLabel.text = genre
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
