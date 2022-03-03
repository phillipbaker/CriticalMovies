//
//  LoadingViewController.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 3/3/22.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var loadingView = UIActivityIndicatorView()
    
    var isLoading = false {
        didSet { updateLoadingView() }
    }

    
    override func loadView() {
        super.loadView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.startAnimating()
    }
    
    private func updateLoadingView() {
        if self.isLoading {
            DispatchQueue.main.async { self.loadingView.isHidden = false }
        } else {
            DispatchQueue.main.async { self.loadingView.isHidden = true }
        }
    }
}
