//
//  CriticsPicksCell.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/22/21.
//

import Foundation
import UIKit

class CriticsPicksCell: UICollectionViewCell, MovieCell {
    var onReuse: () -> Void = {}
    var imageView = UIImageView.makeMovieImageView()
    var imageService = ImageService()
    
    private(set) var titleLabel = UILabel.makeLabel(withTextStyle: .title2)
    private(set) var dateLabel = UILabel.makeLabel(withTextStyle: .caption1, andTextColor: .tintColor)
    private(set) var reviewerLabel = UILabel.makeLabel(withTextStyle: .caption1, andTextColor: .tintColor)
    private(set) var descriptionLabel = UILabel.makeLabel(withTextStyle: .body, andTextColor: .secondaryLabel)
    private(set) lazy var stackView: UIStackView = makeStackView()
    
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
        dateLabel.text = movie.publicationDate?.formatted().uppercased() ?? "Unknown Date"
        reviewerLabel.text = "by \(movie.byline.uppercased())"
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
        imageView.image = MovieImage.placeholder
        imageView.contentMode = .center
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [reviewerLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stackView)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.cornerCurve = .continuous
        contentView.backgroundColor = UIColor.descriptionBackground
        
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
