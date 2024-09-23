//
//  NowShowingCollectionViewCell.swift
//  Kino
//
//  Created by Viktoriya Polozova on 19/08/2024.
//

import UIKit

class NowShowingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private weak var star: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var imdbRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        imageView.layer.cornerRadius = 8
    }
    
    public func configure(movieInfo: NowShowingMovie) {
        if let image = movieInfo.image {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        movieTitle.text = movieInfo.title
        imdbRating.text = movieInfo.imdbRating != nil ? "\(movieInfo.imdbRating!) IMDb" : "N/A IMDb"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "NowShowingCollectionViewCell", bundle: nil)
    }
}
