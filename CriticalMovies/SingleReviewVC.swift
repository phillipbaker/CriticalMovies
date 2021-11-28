//
//  SingleReviewVC.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/26/21.
//

import UIKit

class SingleReviewVC: UIViewController {
    var movie: Movie
    let review = CMMovieReview()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        view.addSubview(review)
        
        NSLayoutConstraint.activate([
            review.topAnchor.constraint(equalTo: view.topAnchor),
            review.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            review.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            review.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
