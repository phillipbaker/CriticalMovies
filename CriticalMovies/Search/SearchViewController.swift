//
//  SearchViewController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/28/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }
}
