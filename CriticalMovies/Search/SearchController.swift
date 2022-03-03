//
//  SearchController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/28/21.
//

import UIKit

class SearchController: UIViewController {
    var collectionView: MovieCollectionView<SearchResultCell>!

    var searchQuery: String?
    var searchController: UISearchController!

    private(set) lazy var errorLabel: UILabel = {
        let label = UILabel.customLabel(withTextColor: .secondaryLabel, withTextStyle: .body)
        label.text = "Could not find any movies matching that search."
        return label
    }()
    
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
        
        searchController.searchBar.placeholder = "Search movies..."
        navigationItem.searchController = searchController
    }
    
    private func layoutErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.isHidden = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SearchController: UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchQuery = searchController.searchBar.text
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getMovies()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearResults()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchController.searchBar.text == "" { clearResults() }
    }
    
    func clearResults() {
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
                self?.collectionView.updateUI(with: result.movies)
            case .failure(let error):
                self?.errorLabel.isHidden = false
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
