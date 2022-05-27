//
//  Constants.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/23/21.
//

import UIKit

enum SFSymbol {
    static let film = UIImage(systemName: "film")
    static let search = UIImage(systemName: "magnifyingglass")
}

enum MovieImage {
    static var placeholder: UIImage = {
        let configuration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "film", withConfiguration: configuration)!
        return image
    }()
}

extension UIColor {
    static let descriptionBackground = UIColor(named: "descriptionBackground")
}
