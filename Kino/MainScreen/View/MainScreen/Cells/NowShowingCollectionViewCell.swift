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
    @IBOutlet private weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        imageView.layer.cornerRadius = 8
    }
    
    public func configure(movieInfo: MovieInfo) {
        imageView.image = movieInfo.previewImage
        movieTitle.text = movieInfo.title
        rating.text = movieInfo.rating
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "NowShowingCollectionViewCell", bundle: nil)
    }
}
