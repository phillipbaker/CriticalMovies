//
//  SearchResultCell.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/27/22.
//

import UIKit

class SearchResultCell: UICollectionViewCell, MovieCell {
    var imageView = MovieImageView(frame: .zero)
    
    private(set) var titleLabel = UILabel.makeHeadlineLabel()
    private(set) var criticsPickLabel = UILabel.makeBoldCaptionLabel()
    private(set) var descriptionLabel = UILabel.makeSecondaryCalloutLabel()
    
    private(set) lazy var titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8)
    
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
        if movie.criticsPick == 1 { showCriticsPickView() }
    }
    
    func showCriticsPickView() {
        contentView.addSubview(criticsPickLabel)
        
        NSLayoutConstraint.deactivate([titleLabelTopConstraint])
        
        NSLayoutConstraint.activate([
            criticsPickLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            criticsPickLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            criticsPickLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            criticsPickLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)
        ])
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.cornerCurve = .continuous
        contentView.backgroundColor = UIColor.descriptionBackground
        
        titleLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        criticsPickLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabelTopConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
