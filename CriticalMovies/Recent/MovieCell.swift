//
//  MovieCell.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/22/21.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    private(set) var imageView = CMCoverImageView(frame: .zero)
    private(set) var titleLabel = CMTitleLabel()
    private(set) var bylineLabel = CMBylineLabel()
    private(set) var summaryLabel = CMSummaryLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func displayContent(for movie: Movie) {
        imageView.downloadImage(from: movie.multimedia.imageUrl)
        titleLabel.text = movie.title
        summaryLabel.text = movie.summary
        bylineLabel.text = "By \(movie.byline)"
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(bylineLabel)
        
        let spacing: CGFloat = 12
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            bylineLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 16),
            bylineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            bylineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            bylineLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

