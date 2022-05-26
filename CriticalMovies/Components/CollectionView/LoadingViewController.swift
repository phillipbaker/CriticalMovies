//
//  LoadingViewController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 3/3/22.
//

import UIKit

class LoadingViewController: UIViewController {
    var loadingView = UIActivityIndicatorView()

    private(set) lazy var noResultsLabel: UILabel = {
        let label = UILabel.makeLabel(withTextStyle: .body, andTextColor: .secondaryLabel)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No reviews matching your search."
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    var isLoading = false {
        didSet { updateLoadingView() }
    }

    var hasMoreToLoad = true {
        didSet { updateNoResultsLabel() }
    }

    override func loadView() {
        super.loadView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.startAnimating()
    }

    private func updateLoadingView() {
        if isLoading {
            DispatchQueue.main.async { self.loadingView.isHidden = false }
        } else {
            DispatchQueue.main.async { self.loadingView.isHidden = true }
        }
    }

    private func updateNoResultsLabel() {
        if hasMoreToLoad {
            DispatchQueue.main.async { self.noResultsLabel.isHidden = true }
        } else {
            DispatchQueue.main.async { self.noResultsLabel.isHidden = false }
        }
    }
}
