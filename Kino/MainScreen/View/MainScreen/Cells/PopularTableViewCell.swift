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
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(movieInfo: MovieInfo) {
        imageMovie.image = movieInfo.previewImage
        movieTitle.text = movieInfo.title
        self.rating.text = movieInfo.rating
        time.text = movieInfo.duration
        self.genres = movieInfo.genres
        
        imageMovie.layer.cornerRadius = 8
        imageMovie.layer.masksToBounds = true
        
        genresCollectionView.reloadData()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    private func setupCollectionView() {
        genresCollectionView.register(GenreCollectionViewCell.nib(), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.estimatedItemSize = CGSize(width: 0, height: 18)
        
        genresCollectionView.collectionViewLayout = flowLayout
    }
}

extension PopularTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        cell.configure(with: genres[indexPath.row])
        return cell
    }
}

extension PopularTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, 
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: 61, height: 18)
//    }
}
