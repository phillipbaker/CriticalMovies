//
//  UIImageView.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 5/27/22.
//

import UIKit

extension UIImageView {
    static func makeMovieImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = MovieImage.placeholder
        imageView.tintColor = .darkGray
        return imageView
    }
}
