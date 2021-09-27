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
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellConfiguration, for: indexPath, item: itemIdentifier)
        }
        
        dataSource.supplementaryViewProvider = { view, kind, index in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        collectionView.dataSource = dataSource
        
        // initial data
        CriticsPicksService.shared.fetchMovies { result in
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
                                               heightDimension: .estimated(360))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(50))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderSupplementaryView.identifier, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
