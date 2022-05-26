//
//  SearchController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/28/21.
//

import UIKit

class SearchController: UIViewController {
    var collectionView: MovieCollectionView<SearchResultCell>!
    
    var searchQuery: String!
    var searchController: UISearchController!
    
    override func loadView() {
        super.loadView()
        collectionView = MovieCollectionView(cell: SearchResultCell(), layout: Layout.resultsLayout)
        collectionView.delegate = self
        addChildViewController(collectionView)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchQuery = ""
        searchController.searchBar.placeholder = "Search movies..."
        navigationItem.searchController = searchController
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        clearResults()
        getMovies()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearResults()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            clearResults()
        } else {
            searchQuery = searchText
        }
    }
    
    private func clearResults() {
        collectionView.hasMoreToLoad = true
        collectionView.movies.removeAll()
        collectionView.updateUI(with: [])
    }
}

extension SearchController: MovieCollectionViewDelegate {
    func getMovies() {
        collectionView.isLoading = true
        
        let resource = SearchResource(offset: collectionView.offset, searchQuery: searchQuery)
        
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
