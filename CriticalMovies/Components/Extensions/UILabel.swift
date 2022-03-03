//
//  UILabel.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/31/22.
//

import UIKit

extension UILabel {
    static func customLabel(withTextColor textColor: UIColor = .label, withTextStyle textStyle: UIFont.TextStyle) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = textColor
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeTitleLabel() -> UILabel {
        let label = UILabel.customLabel(withTextStyle: .title2)
        return label
    }
    
    static func makeHeadlineLabel() -> UILabel {
        let label = UILabel.customLabel(withTextStyle: .headline)
        return label
    }
    
    static func makeSecondaryBodyLabel() -> UILabel {
        let label = UILabel.customLabel(withTextColor: .secondaryLabel, withTextStyle: .body)
        return label
    }
    
    static func makeSecondaryCalloutLabel() -> UILabel {
        let label = UILabel.customLabel(withTextColor: .secondaryLabel, withTextStyle: .callout)
        return label
    }
    
    static func makeCaptionLabel() -> UILabel {
        let label = UILabel.customLabel(withTextColor: .tintColor, withTextStyle: .caption1)
        return label
    }
    
    static func makeBoldCaptionLabel() -> UILabel {
        let label = UILabel.makeCaptionLabel()
        label.font = label.font.bold()
        label.text = "Critic’s Pick"
        return label
    }
}
