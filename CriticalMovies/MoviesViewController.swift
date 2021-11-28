//
//  MoviesViewController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/21/21.
//

import UIKit

class MoviesViewController: UIViewController {
    
    enum Section { case recent }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    var offset = 0
    var isLoadingReviews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureViewController() {
        title = "NYT Critic’s Picks"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        let cellConfiguration = UICollectionView.CellRegistration<MovieCell, Movie> { cell, indexPath, movie in
            cell.displayContent(for: movie)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <SectionHeaderSupplementaryView>(elementKind: SectionHeaderSupplementaryView.identifier) {
            supplementaryView, string, indexPath in
            supplementaryView.label.text = "Recent"
            supplementaryView.label.font = UIFont.preferredFont(forTextStyle: .headline)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellConfiguration, for: indexPath, item: itemIdentifier)
        }
        
        dataSource.supplementaryViewProvider = { view, kind, index in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        collectionView.dataSource = dataSource
        
        // initial data
        CriticsPicksService.shared.fetchMovies(atOffset: offset) { result in
            switch result {
            case .success(let criticsPicks):
                var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
                snapshot.appendSections([.recent])
                snapshot.appendItems(criticsPicks.movies)
                self.dataSource.apply(snapshot, animatingDifferences: false)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.875),
                                               heightDimension: .estimated(500))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(50))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderSupplementaryView.identifier, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}


extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        let destinationVC = SingleReviewVC(movie: movie)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}


extension MoviesViewController {
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let offsetX = scrollView.contentOffset.x
//        let contentWidth = scrollView.contentSize.width
//        let width = scrollView.frame.size.width
//
//        if offsetX > contentWidth - width {
//            // guard that there are more reviews to load
//            offset += 20
//            loadReviews(atOffset: offset)
//        }
//    }
//
//    func loadReviews(atOffset offset: Int) {
//        showLoadingView()
//        isLoadingReviews = true
//
//        CriticsPicksService.shared.fetchMovies(atOffset: offset) { [weak self] result in
//            guard let self = self else { return }
//            dismissLoadingView()
//
//            switch result {
//            case .success(let reviews):
//                self.updateUI(with: reviews)
//            case .failure(let error):
//                // handle error here...
//                print(error)
//            }
//
//            self.isLoadingReviews = false
//        }
//
//    func showLoadingView() {
//        containerView = UIView(frame: view.bounds)
//        view.addSubview(containerView)
//
//        containerView.backgroundColor = .systemBackground
//        containerView.alpha = 0
//
//        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
//
//        let activityIndicator = UIActivityIndicatorView(style: .large)
//        containerView.addSubview(activityIndicator)
//
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
//        ])
//
//        activityIndicator.startAnimating()
//    }
//
//
//        func dismissLoadingView() {
//            DispatchQueue.main.async {
//                self.containerView.removeFromSuperview()
//                self.containerView = nil
//            }
//        }
//
//    }
}
