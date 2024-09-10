//
//  ActorCollectionViewCell.swift
//  Kino
//
//  Created by Viktoriya Polozova on 06/09/2024.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - GUI Variables
    
    private lazy var actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(actorImageView)
        contentView.addSubview(nameLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(with actor: Actor) {
        actorImageView.image = actor.avatar
        nameLabel.text = actor.fullName
    }
    
    // MARK: - Constraints
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            actorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actorImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            actorImageView.widthAnchor.constraint(equalToConstant: 72),
            actorImageView.heightAnchor.constraint(equalToConstant: 72),
            
            nameLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
