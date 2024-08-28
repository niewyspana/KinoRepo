//
//  DetailsViewController.swift
//  Kino
//
//  Created by Viktoriya Polozova on 21/08/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - GUI Variables
    
    var trailerImageView = UIImageView()
    private var genres: [String] = ["ACTION", "ADVENTURE", "FANTASY"]
    
    private lazy var genresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.nib(), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private lazy var playLabel: UILabel = {
        let label = UILabel()
        label.text = "Play Trailer"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Neverending Story"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.tintColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.1/10 IMDb"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var viewModel: DetailsViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        trailerImageView.image = UIImage(named: "trailer")
        trailerImageView.translatesAutoresizingMaskIntoConstraints = false
        configureUI()
        
        navigationController?.navigationBar.tintColor = .white
        
        let moreButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(moreButtonTapped))
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        
        navigationItem.rightBarButtonItem = moreButton
        navigationItem.leftBarButtonItem = backButton
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        fillUIFromViewModel()
    }
    
    
    func fillUIFromViewModel() {
        trailerImageView.image = viewModel.model.previewImage
        movieTitleLabel.text = viewModel.model.title
        ratingLabel.text = "\(viewModel.model.imdbRating) IMDb"
        genres = viewModel.model.genres
        genresCollectionView.reloadData()
        
    }
    
    @objc private func moreButtonTapped() {
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(trailerImageView)
        contentView.addSubview(playButton)
        contentView.addSubview(playLabel)
        contentView.addSubview(roundedView)
        
        roundedView.addSubview(movieTitleLabel)
        roundedView.addSubview(starImageView)
        roundedView.addSubview(ratingLabel)
        roundedView.addSubview(bookmarkButton)
        roundedView.addSubview(genresCollectionView)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            trailerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            trailerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trailerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trailerImageView.heightAnchor.constraint(equalToConstant: 260)
        ])
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: trailerImageView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: trailerImageView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            playLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 8),
            playLabel.centerXAnchor.constraint(equalTo: playButton.centerXAnchor)
        ])
        
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: trailerImageView.bottomAnchor, constant: -25), roundedView.leadingAnchor.constraint(equalTo: view.leadingAnchor), roundedView.trailingAnchor.constraint(equalTo: view.trailingAnchor), roundedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 16),
            bookmarkButton.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -16),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 30),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
            starImageView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            genresCollectionView.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 12),
            genresCollectionView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 16),
            genresCollectionView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -16),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    @objc func playButtonTapped() {
        print("Play button tapped")
    }
}

extension DetailsViewController: UICollectionViewDataSource {
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
