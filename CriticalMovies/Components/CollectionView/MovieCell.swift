//
//  MovieCell.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 2/18/22.
//

import UIKit

protocol MovieCell: UICollectionViewCell {
    func displayContent(for movie: Movie)
    var imageView: UIImageView { get set }
}
