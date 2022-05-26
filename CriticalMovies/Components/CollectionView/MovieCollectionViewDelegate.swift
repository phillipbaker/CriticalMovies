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
}
