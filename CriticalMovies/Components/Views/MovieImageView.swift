//
//  CMCoverImageView.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/27/21.
//

import UIKit

protocol MovieImageViewDelegate: AnyObject {
    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, MovieError>) -> Void)
}

class MovieImageView: UIImageView {
    weak var delegate: MovieImageViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }

    func downloadImage(from url: String) {
        delegate?.downloadImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async { self?.image = image }
            case .failure:
                DispatchQueue.main.async { self?.image = Image.film }
            }
        }
    }
}
