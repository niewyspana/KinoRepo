//
//  NowShowingCollectionViewCell.swift
//  Kino
//
//  Created by Viktoriya Polozova on 19/08/2024.
//

import UIKit

class NowShowingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    static let identifier = "NowShowingCollectionViewCell"
    
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
