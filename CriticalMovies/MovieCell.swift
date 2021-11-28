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
    private(set) var spacer = VerticalSpacerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func displayContent(for movie: Movie) {
        imageView.downloadImage(fromUrl: movie.multimedia.imageUrl)
        titleLabel.text = movie.title
        bylineLabel.text = "By \(movie.byline)"
        summaryLabel.text = movie.summary
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(bylineLabel)
        contentView.addSubview(spacer)
        
        contentView.backgroundColor = .tertiarySystemFill
        
        
        let spacing: CGFloat = 12
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            bylineLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: spacing),
            bylineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            bylineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            bylineLabel.bottomAnchor.constraint(lessThanOrEqualTo: spacer.topAnchor),

            spacer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spacer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}

