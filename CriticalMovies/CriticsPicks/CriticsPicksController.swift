//
//  CriticsPicksController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/21/21.
//

import UIKit

class CriticsPicksController: UIViewController {
    var collectionView: MovieCollectionView<CriticsPicksCell>!

    override func loadView() {
        super.loadView()
        collectionView = MovieCollectionView(cell: CriticsPicksCell(), layout: Layout.criticsPicksLayout)
        collectionView.delegate = self
        addChildViewController(collectionView)
        getMovies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Critics’ Picks"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension CriticsPicksController: MovieCollectionViewDelegate {
    func getMovies() {
        collectionView.isLoading = true

        let resource = CriticResource(offset: collectionView.offset)

        MoviesService.shared.fetchMovies(from: resource.url) { [weak self] result in
            switch result {
            case .success(let result):
                if let movies = result.movies {
                    self?.collectionView.updateUI(with: movies)
                } else {
                    self?.collectionView.hasMoreToLoad = false
                }
            case .failure(let error):
                print(error)
            }

            self?.collectionView.isLoading = false
        }
    }

    func loadReview(for url: String) {
        let webVC = WebView(url: url)
        let navVC = UINavigationController(rootViewController: webVC)
        present(navVC, animated: true)
    }
}
