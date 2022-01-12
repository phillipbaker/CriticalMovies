//
//  CMBylineLabel.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/27/21.
//

import UIKit

class CMBylineLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        numberOfLines = 0
        textColor = .secondaryLabel
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .callout)
    }
    
    func createAttributedByline(from byline: String) -> NSAttributedString {
        let attributedByline = NSMutableAttributedString(string: "By ")
        
        let italicAttribute = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .callout).italic()]
        let attributedAuthor = NSAttributedString(string: byline, attributes: italicAttribute)
        
        attributedByline.append(attributedAuthor)
        return attributedByline
    }
}
