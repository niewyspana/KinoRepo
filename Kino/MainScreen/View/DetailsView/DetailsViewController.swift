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
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var isBookmarked = false
    
    @objc private func bookmarkButtonTapped() {
        isBookmarked.toggle()
        let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
        bookmarkButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private lazy var lengthLabel: UILabel = {
        let label = UILabel()
        label.text = "Length"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lengthStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lengthLabel, durationLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var languageTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var languageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [languageLabel, languageTypeLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var pgRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pgRatingNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pgRatingLabel, pgRatingNumberLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lengthStackView, languageStackView, ratingStackView])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "StixTwoText-Bold", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var headerView: HeaderView = {
        let header = HeaderView.loadFromNib()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.configure(with: "Cast", buttonTitle: "See more")
        header.seeMoreClosure = { [weak self] in
            self?.handleSeeMoreTapped()
        }
        return header
    }()
    
    private lazy var actorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 100, height: 150)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: "ActorCell")
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private func handleSeeMoreTapped() {
        print("See More button tapped")
    }
    
    var viewModel: DetailsViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        trailerImageView.image = UIImage(named: "trailer")
        trailerImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        setupUI()
    }
    
    func setupUI() {
        trailerImageView.image = viewModel.model.previewImage
        movieTitleLabel.text = viewModel.model.title
        ratingLabel.text = "\(viewModel.model.imdbRating) IMDb"
        genres = viewModel.model.genres
        pgRatingNumberLabel.text = viewModel.model.rating
        languageTypeLabel.text = viewModel.model.language
        durationLabel.text = viewModel.model.duration
        movieDescriptionLabel.text = viewModel.model.descriptionText
        
        genresCollectionView.reloadData()
        actorsCollectionView.reloadData()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(trailerImageView, playButton, playLabel, roundedView)
        roundedView.addSubviews(movieTitleLabel, starImageView, ratingLabel, bookmarkButton, genresCollectionView, infoStackView, descriptionLabel, movieDescriptionLabel, headerView, actorsCollectionView)
        
        setUpConstraints()
    }
    
    @objc private func moreButtonTapped() {
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
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
            roundedView.topAnchor.constraint(equalTo: trailerImageView.bottomAnchor, constant: -25),
            roundedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roundedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: genresCollectionView.bottomAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(lessThanOrEqualTo: roundedView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            movieDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            movieDescriptionLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 16),
            movieDescriptionLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            actorsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            actorsCollectionView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 16),
            actorsCollectionView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -16),
            actorsCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func playButtonTapped() {
        print("Play button tapped")
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genresCollectionView {
            return genres.count
        } else if collectionView == actorsCollectionView {
            return viewModel.actors.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genresCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: genres[indexPath.row])
            return cell
        } else if collectionView == actorsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as? ActorCollectionViewCell else {
                return UICollectionViewCell()
            }
            let actor = viewModel.actors[indexPath.row]
            cell.configure(with: actor)
            return cell
        }
        return UICollectionViewCell()
    }
}
