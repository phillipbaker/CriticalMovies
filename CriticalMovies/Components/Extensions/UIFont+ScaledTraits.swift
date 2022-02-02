//
//  UIFont+ScaledTraits.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/12/22.
//

import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) // at it’s current size
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}
