//
//  CriticsPicksController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/21/21.
//

import UIKit

class CriticsPicksController: UIViewController {
    var criticsPicksCollectionView: CriticsPicksCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Critics’ Picks"
        navigationController?.navigationBar.prefersLargeTitles = true

        criticsPicksCollectionView = CriticsPicksCollectionView()
        criticsPicksCollectionView.delegate = self
        addChildViewController(criticsPicksCollectionView)
    }
}

extension CriticsPicksController: CriticsPicksCollectionViewDelegate {
    func getMovies() {
        criticsPicksCollectionView.isLoading = true

        let resource = CriticResource(offset: criticsPicksCollectionView.offset)

        MoviesService.shared.fetchMovies(from: resource.url) { [weak self] result in
            switch result {
            case .success(let result):
                self?.criticsPicksCollectionView.updateUI(with: result.movies)
            case .failure(let error):
                print(error)
            }

            self?.criticsPicksCollectionView.isLoading = false
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
