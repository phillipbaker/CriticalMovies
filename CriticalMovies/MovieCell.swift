//
//  MovieCell.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/22/21.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var bylineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayContent(for movie: Movie) {
        CriticsPicksService.shared.downloadImage(from: movie.multimedia.imageUrl) { image in
            guard image != nil else { return }
            DispatchQueue.main.async { self.imageView.image = image }
        }
        titleLabel.text = movie.title
        summaryLabel.text = movie.summary
        bylineLabel.text = "By \(movie.byline)"
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(bylineLabel)
        
        let spacing: CGFloat = 8
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bylineLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: spacing),
            bylineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bylineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bylineLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
}

