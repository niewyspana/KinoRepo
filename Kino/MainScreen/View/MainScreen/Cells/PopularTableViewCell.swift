//
//  PopularTableViewCell.swift
//  Kino
//
//  Created by Viktoriya Polozova on 19/08/2024.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    
    static let identifier = "PopularTableViewCell"
    
    
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var clock: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    private var genres: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genresCollectionView.register(GenreCollectionViewCell.nib(), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with image: UIImage, star: UIImage, title: String, rating: String, timeText: String, clockImage: UIImage, genres: [String]) {
        imageMovie.image = image
        self.star.image = star
        movieTitle.text = title
        self.rating.text = rating
        time.text = timeText
        clock.image = clockImage
        self.genres = genres
        
        imageMovie.layer.cornerRadius = 8
        imageMovie.layer.masksToBounds = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
