//
//  CMMovieReview.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/27/21.
//

import UIKit

class CMMovieReview: UIView {
    
    let imageView = CMCoverImageView(frame: .zero)
    let titleLabel = CMTitleLabel()
    let bylineLabel = CMBylineLabel()
//    let reviewBody = CMReviewBody()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(bylineLabel)
//        addSubview(reviewBody)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 32),
            
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bylineLabel.topAnchor, constant: 16),
            
            bylineLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bylineLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bylineLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
//            bylineLabel.bottomAnchor.constraint(equalTo: reviewBody.topAnchor, constant: 24),
//
//            reviewBody.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            reviewBody.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            reviewBody.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
