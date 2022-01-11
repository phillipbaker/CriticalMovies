//
//  MoviesViewController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/21/21.
//

import UIKit

class RecentMoviesViewController: UIViewController {
    
    // MARK: - Section Enum
    
    enum Section: Int, Hashable, CaseIterable {
        case recent
    }
    
    
    // MARK: - Properties

    var offset = 0
    var movies: [Movie] = []
    var isLoadingMovies = false

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
    }
    
    
    // MARK: - View Methods
    
    private func configureViewController() {
        navigationItem.title = "Recent"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    
    func getMovies(at offset: Int) {
        isLoadingMovies = true
        
        CriticsPicksService.shared.fetchMovies(atOffset: offset) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let criticsPicks):
                self.updateUI(with: criticsPicks.movies)
            case .failure(let error):
                print(error)
            }
            
            self.isLoadingMovies = false
        }
    }
    
    
    func updateUI(with movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        self.updateData(movies: self.movies)
    }
    
    
    func updateData(movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.recent])
        snapshot.appendItems(movies)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    
//    func showLoadingView() -> UIView {
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        
//        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.center = container.center
//        container.addSubview(activityIndicator)
//        
//        activityIndicator.startAnimating()
//        return container
//    }
    
    
    // MARK: - Compositional Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(500)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(16)
            
            section = NSCollectionLayoutSection(group: group)
            
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
            
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        return layout
    }
    
    
    // MARK: - Data Source
    
    private func configureDataSource() {
        let movieCellRegistration = UICollectionView.CellRegistration<MovieCell, Movie> { cell, indexPath, movie in
            cell.displayContent(for: movie)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: movieCellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        collectionView.dataSource = dataSource
        
        // Initial data
        getMovies(at: offset)
    }
}

extension RecentMoviesViewController: UICollectionViewDelegate {
    
    // MARK: - Load Review in Web View
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        let urlString = movie.link.reviewUrl
        let webVC = WebViewController(urlString: urlString)
        let navVC = UINavigationController(rootViewController: webVC)
        present(navVC, animated: true)
    }
    
    
    // MARK: - Load More Movies on End Scroll
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrollPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if scrollPosition > contentHeight - height {
            guard !isLoadingMovies else { return }
            offset += 20
            getMovies(at: offset)
        }
    }
}