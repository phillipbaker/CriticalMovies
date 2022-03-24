//
//  UILabel.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/31/22.
//

import UIKit

extension UILabel {
    static func makeLabel(withTextStyle textStyle: UIFont.TextStyle, andTextColor textColor: UIColor = .label) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = textColor
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
