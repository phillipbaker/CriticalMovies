//
//  VerticalSpacerView.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 11/27/21.
//

import UIKit

class VerticalSpacerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}
