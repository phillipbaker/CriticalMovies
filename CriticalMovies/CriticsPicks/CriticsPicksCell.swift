//
//  CriticsPicksCell.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/22/21.
//

import Foundation
import UIKit

class CriticsPicksCell: UICollectionViewCell, MovieCell {
    var imageView = MovieImageView(frame: .zero)
    
    private(set) var titleLabel = UILabel.makeTitleLabel()
    private(set) var dateLabel = UILabel.makeCaptionLabel()
    private(set) var reviewerLabel = UILabel.makeCaptionLabel()
    private(set) var descriptionLabel = UILabel.makeSecondaryBodyLabel()
        
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewerLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func displayContent(for movie: Movie) {
        imageView.downloadImage(from: movie.multimedia.imageUrl)
        titleLabel.text = movie.title
        descriptionLabel.text = movie.summary
        dateLabel.text = movie.publicationDate.formatted().uppercased()
        reviewerLabel.text = "by \(movie.byline.uppercased())"
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stackView)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.cornerCurve = .continuous
        contentView.backgroundColor = UIColor.descriptionBackground
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
