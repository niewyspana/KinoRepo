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
            trailerImageView.heightAnchor.constraint(equalToConstant: 200)
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
    }
    
    @objc func playButtonTapped() {
        print("Play button tapped")
    }
}
