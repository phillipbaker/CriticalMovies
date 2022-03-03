//
//  SearchControllerTests.swift
//  CriticalMoviesTests
//
//  Created by Phillip Baker on 2/18/22.
//

@testable import CriticalMovies
import XCTest

class SearchControllerTests: XCTestCase {
    // MARK: - Properties
    
    private var sut: SearchController!
    
    // MARK: - Setup and Teardown
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - View Controller Tests
    
    func test_searchController_ShouldLoad() {
        XCTAssertNotNil(sut)
    }
    
    func test_navigationTitle_shouldBeSearch() {
        XCTAssertEqual(sut.navigationItem.title, "Search")
    }
    
    func test_navigationTitle_shouldPreferLargeTitles() {
        guard let navigationController = sut.navigationController else {
            print("navigation controller is nil")
            return
        }

        XCTAssert(navigationController.navigationBar.prefersLargeTitles == true)
    }
    
    // MARK: - Error Label Tests
    
    func test_searchController_shouldLoadErrorLabel() {
        XCTAssertNotNil(sut.errorLabel)
    }
    
    func test_errorLabelTextColor_shouldBeSecondary() {
        XCTAssertEqual(sut.errorLabel.textColor, .secondaryLabel)
    }
    
    func test_errorLabelTextStyle_shouldBeBody() {
        XCTAssert(sut.errorLabel.font == UIFont.preferredFont(forTextStyle: .body))
    }
    
    func test_errorLabelText_shouldBeCouldNotFindMovies() {
        XCTAssertEqual(sut.errorLabel.text, "Could not find any movies matching that search.")
    }
    
    // MARK: - Search Tests
    
    func test_searchController_shouldLoadSearchController() {
        XCTAssertNotNil(sut.searchController)
    }
    
    func test_searchBarDelegate_shouldBeConnected() {
        XCTAssertNotNil(sut.searchController.searchBar.delegate, "search bar delegate")
    }
    
    func test_searchQuery_shouldBeNil() {
        XCTAssertNil(sut.searchQuery)
    }
    
    func test_navigationSearchController_ShouldBeSearchController() {
        XCTAssertEqual(sut.navigationItem.searchController, sut.searchController)
    }
    
    func test_searchBarPlaceholderText_ShouldBeSearchMovies() {
        XCTAssertEqual(sut.searchController.searchBar.placeholder, "Search movies...")
    }
    
    // MARK: - Collection View Tests
    
    func test_searchController_shouldCreateCollectionView() {
        XCTAssertNotNil(sut.collectionView)
    }
    
    func test_searchController_shouldAddChildCollectionView() {
        XCTAssertNotNil(sut.children)
    }

    func test_collectionViewLayout_shouldBeSearchResultsLayout() {
        XCTAssert(sut.collectionView.layout == Layout.resultsLayout)
    }
        
    func test_collectionViewDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.collectionView.delegate, "collection view delegate")
        XCTAssertNotNil(sut.collectionView.dataSource, "collection view data source")
    }
}
