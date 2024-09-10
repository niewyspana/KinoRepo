//
//  PopularTableViewCell.swift
//  Kino
//
//  Created by Viktoriya Polozova on 19/08/2024.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    @IBOutlet private weak var genresCollectionView: AutoContentSizeCollectionView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var star: UIImageView!
    @IBOutlet private weak var clock: UIImageView!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var imageMovie: UIImageView!
    
    private var genres: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        makeCellSelectionColorClear()
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
        genresCollectionView.layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        genresCollectionView.register(GenreCollectionViewCell.nib, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        genresCollectionView.dataSource = self
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        genresCollectionView.collectionViewLayout = layout
    }
    
    private func makeCellSelectionColorClear() {
        let clearColorView = UIView()
        clearColorView.backgroundColor = .clear
        self.selectedBackgroundView = clearColorView
    }
}

extension PopularTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
                return UICollectionViewCell()
            }
        cell.configure(with: genres[indexPath.row])
        return cell
    }
}

final class AutoContentSizeCollectionView: UICollectionView {
    // MARK: - Public Properties
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: contentSize.width + contentInset.left + contentInset.right,
            height: contentSize.height + contentInset.top + contentInset.bottom)
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
