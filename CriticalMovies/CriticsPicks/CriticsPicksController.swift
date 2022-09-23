//
//  CriticsPicksController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/21/21.
//

import UIKit

class CriticsPicksController: UIViewController {
    var collectionView: MovieCollectionView<CriticsPicksCell>!
    var movieReviewService: MovieReviewService!
    
    override func loadView() {
        super.loadView()
        collectionView = MovieCollectionView(cell: CriticsPicksCell(), layout: Layout.criticsPicksLayout)
        movieReviewService = MovieReviewService()
        collectionView.delegate = self
        addChildViewController(collectionView)
        getMovies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Critics’ Picks"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func launchSettings() {
        guard let bundleId = Bundle.main.bundleIdentifier else { return }
        let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")!
        UIApplication.shared.open(url)
    }
}

extension CriticsPicksController: MovieCollectionViewDelegate {
    func getMovies() {
        collectionView.isLoading = true

        let resource = CriticsPicksResource(offset: collectionView.offset)
        
        guard let resourceUrl = resource.url else { return }
        let request = URLRequest(url: resourceUrl)

        movieReviewService.loadMovieReviews(with: request) { [weak self] result in
            switch result {
            case .success(let result):
                if let movies = result.movies {
                    self?.collectionView.updateUI(with: movies)
                } else {
                    self?.collectionView.hasMoreToLoad = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(
                        title: error.rawValue,
                        message: "Please check your network settings or try again later.",
                        preferredStyle: .alert
                    )
                    
                    let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
                    
                    let settings = UIAlertAction(title: "Go to Settings", style: .default) { _ in
                        self?.launchSettings()
                    }
                    
                    alert.addAction(dismiss)
                    alert.addAction(settings)
                    
                    self?.present(alert, animated: true)
                }
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
