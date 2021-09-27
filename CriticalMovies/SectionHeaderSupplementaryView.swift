//
//  SectionHeaderSupplementaryView.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/27/21.
//

import UIKit

class SectionHeaderSupplementaryView: UICollectionReusableView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        addSubview(label)
        
        let spacing = CGFloat(10)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing)
        ])
    }
}
