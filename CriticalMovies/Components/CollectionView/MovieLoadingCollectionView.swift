//
//  MovieLoadingCollectionView.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/27/22.
//

import UIKit

protocol MovieLoadingCollectionViewDelegate: AnyObject {
    func getMovies()
    func loadReview(for url: String)
    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, MovieError>) -> Void)
}

class MovieLoadingCollectionView<Cell: MovieCell>: UIViewController, UICollectionViewDelegate {
    enum Section { case main }
    
    var cell: Cell
    var layout: UICollectionViewCompositionalLayout
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    var collectionView: UICollectionView!
    
    var offset = 0
    var movies: [Movie] = []
    var loadingView = LoadingView()
    var isLoading = false { didSet { updateLoadingView() } }

    weak var delegate: MovieLoadingCollectionViewDelegate?
    
    
    init(cell: Cell, layout: UICollectionViewCompositionalLayout) {
        self.cell = cell
        self.layout = layout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }

    func updateUI(with movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        updateData(movies: self.movies)
    }

    func updateData(movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<Cell, Movie> { cell, _, movie in
            cell.imageView.delegate = self
            cell.displayContent(for: movie)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }

        let footerRegistration = UICollectionView.SupplementaryRegistration(elementKind: "spinner") { supplementaryView, _, _ in
            supplementaryView.addSubview(self.loadingView)
            self.loadingView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                self.loadingView.centerXAnchor.constraint(equalTo: supplementaryView.centerXAnchor),
                self.loadingView.centerYAnchor.constraint(equalTo: supplementaryView.centerYAnchor)
            ])
        }

        dataSource.supplementaryViewProvider = { _, _, index in
            self.collectionView.dequeueConfiguredReusableSupplementary(
                using: footerRegistration, for: index)
        }

        collectionView.dataSource = dataSource
    }

    private func updateLoadingView() {
        if isLoading {
            DispatchQueue.main.async { self.loadingView.isHidden = false }
        } else {
            DispatchQueue.main.async { self.loadingView.isHidden = true }
        }
    }
    
    // MARK: - Load Review in Web View

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        delegate?.loadReview(for: movie.link.reviewUrl)
    }

    // MARK: - Load More Movies on End Scroll

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrollPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        let height = scrollView.frame.size.height

        // If movies is empty, pulling down (to refresh) calls getMovies because contentOffset.y starting value is .zero
        if !movies.isEmpty, scrollPosition > contentHeight - height {
            guard !isLoading else { return }
            offset += 20
            delegate?.getMovies()
        }
    }
}

extension MovieLoadingCollectionView: MovieImageViewDelegate {
    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        delegate?.downloadImage(from: url, withCompletion: completion)
    }
}
