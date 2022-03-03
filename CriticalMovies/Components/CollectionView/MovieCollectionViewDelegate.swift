//
//  MovieCollectionViewDelegate.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 3/3/22.
//

import UIKit

protocol MovieCollectionViewDelegate: AnyObject {
    func getMovies()
    func loadReview(for url: String)
    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, MovieError>) -> Void)
}

extension MovieCollectionViewDelegate {
    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        MoviesService.shared.downloadImage(from: url, withCompletion: completion)
    }
}
