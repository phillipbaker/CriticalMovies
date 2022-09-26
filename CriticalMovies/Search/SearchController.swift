//
//  SearchController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/28/21.
//

import UIKit

class SearchController: UIViewController {
    var collectionView: MovieCollectionView<SearchResultCell>
    var dataService: DataService
    var searchController: UISearchController
    var searchQuery: String?
    
    init(collectionView: MovieCollectionView<SearchResultCell>, dataService: DataService, searchController: UISearchController) {
        self.collectionView = collectionView
        self.dataService = dataService
        self.searchController = searchController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        collectionView.delegate = self
        addChildViewController(collectionView)
        searchController.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        
        dataService.load(resource) { [weak self] result in
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
