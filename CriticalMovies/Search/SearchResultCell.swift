//
//  SearchResultCell.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/27/22.
//

import UIKit

class SearchResultCell: UICollectionViewCell, MovieCell {
    var dataService = DataService()
    var imageService = ImageService()
    
    var onReuse: () -> Void = {}
    var imageView = UIImageView.makeMovieImageView()
    private(set) var titleLabel = UILabel.makeLabel(withTextStyle: .headline)
    private(set) var descriptionLabel = UILabel.makeLabel(withTextStyle: .callout, andTextColor: .secondaryLabel)
    private(set) lazy var criticsPickLabel = makeCriticsPickLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func displayContent(for movie: Movie) {
        fetchMovieImage(for: movie)
        titleLabel.text = movie.title
        descriptionLabel.text = movie.summary
        if movie.isCriticsPick { displayCriticsPickLabel() }
    }
    
    private func fetchMovieImage(for movie: Movie) {
        /// Image set to placeholder by default so we just return.
        guard let imageUrl = movie.image else { return }
        
        /// Using optional try because we set the image on imageView and reset to the placeholder in onReuse.
        let token = imageService.downloadImage(from: imageUrl) { result in
            let image = try? result.get()
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.imageView.contentMode = .scaleAspectFill
            }
        }
        
        onReuse = {
            guard let token = token else { return }
            self.imageService.cancelImageRequest(token)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        removeCriticsPickLabel()
        imageView.image = MovieImage.placeholder
        imageView.contentMode = .center
    }
    
    private func makeCriticsPickLabel() -> UILabel {
        let label = UILabel.makeLabel(withTextStyle: .caption1, andTextColor: .tintColor)
        label.font = label.font.bold()
        label.text = "Critic’s Pick"
        return label
    }
    
    private func displayCriticsPickLabel() {
        contentView.addSubview(criticsPickLabel)
        titleLabelTopConstraint.isActive = false
        NSLayoutConstraint.activate(criticsPickConstraints)
    }
    
    private func removeCriticsPickLabel() {
        criticsPickLabel.removeFromSuperview()
        titleLabelTopConstraint.isActive = true
        NSLayoutConstraint.deactivate(criticsPickConstraints)
    }
    
    private lazy var titleLabelTopConstraint: NSLayoutConstraint = {
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8)
    }()
    
    private lazy var criticsPickConstraints: [NSLayoutConstraint] = {[
        criticsPickLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
        criticsPickLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        criticsPickLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        criticsPickLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)]
    }()
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.cornerCurve = .continuous
        contentView.backgroundColor = UIColor.descriptionBackground
        
        titleLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        criticsPickLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabelTopConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
