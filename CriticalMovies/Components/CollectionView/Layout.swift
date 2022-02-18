//
//  UIHelper.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/27/22.
//

import UIKit

enum Layout {
    
    // MARK: - Critics Picks Layout
    
    static var criticsPicksLayout: UICollectionViewCompositionalLayout = {
        let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(500))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(16)
            
            section = NSCollectionLayoutSection(group: group)
            
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

            section.boundarySupplementaryItems = Layout.createFooterSupplementaryItem()

            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)

        return layout
    }()
    
    
    // MARK: - Search Results Layout
    
    static var resultsLayout: UICollectionViewCompositionalLayout = {
        let sectionProvider = {
            (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(50))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(50))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(16)
            
            section = NSCollectionLayoutSection(group: group)
            
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

            section.boundarySupplementaryItems = Layout.createFooterSupplementaryItem()

            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)

        return layout
    }()
    
    
    // MARK: - Footer Supplementary View
    
    static func createFooterSupplementaryItem() -> [NSCollectionLayoutBoundarySupplementaryItem] {
        let footerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        
        let footerSupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerItemSize,
            elementKind: "spinner",
            alignment: .bottom)
        
        return [footerSupplementaryItem]
    }
}
