//
//  CriticsPicksController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/21/21.
//

import UIKit

class CriticsPicksController: UIViewController {
    var collectionView: MovieLoadingCollectionView<CriticsPicksCell>!
    
    override func loadView() {
        super.loadView()
        collectionView = MovieLoadingCollectionView(cell: CriticsPicksCell(), layout: Layout.criticsPicksLayout)
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

extension CriticsPicksController: MovieLoadingCollectionViewDelegate {
    func getMovies() {
        collectionView.isLoading = true

        let resource = CriticResource(offset: collectionView.offset)

        MoviesService.shared.fetchMovies(from: resource.url) { [weak self] result in
            switch result {
            case .success(let result):
                self?.collectionView.updateUI(with: result.movies)
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

    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        MoviesService.shared.downloadImage(from: url, withCompletion: completion)
    }
}
