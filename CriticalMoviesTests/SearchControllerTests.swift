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
    
    override func setUp() {
        super.setUp()
        sut = SearchController(
            collectionView: .init(cell: SearchResultCell(), layout: Layout.resultsLayout),
            dataService: .init(),
            searchController: UISearchController(searchResultsController: nil)
        )
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - View Controller Tests
    
    func test_searchController_ShouldLoad() {
        XCTAssertNotNil(sut)
    }
    
    func test_navigationTitle_shouldBeSearch() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.navigationItem.title, "Search")
    }
    
    func test_navigationTitle_shouldPreferLargeTitles() {
        guard let navigationController = sut.navigationController else {
            print("navigation controller is nil")
            return
        }

        XCTAssert(navigationController.navigationBar.prefersLargeTitles == true)
    }
    
    // MARK: - Collection View Tests
    
    func test_searchController_shouldCreateCollectionView() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.collectionView)
    }
    
    func test_searchController_shouldAddChildCollectionView() {
        XCTAssertNotNil(sut.children)
    }
    
    func test_searchController_shouldConnectCollectionViewDelegate() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.collectionView.delegate, "collection view delegate")
    }
    
    func test_searchController_shouldConnectCollectionViewDataSource() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.collectionView.dataSource, "collection view data source")
    }

    func test_collectionViewLayout_shouldBeSearchResultsLayout() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.collectionView.layout, Layout.resultsLayout)
    }
    
    // MARK: - Search Controller Tests
    
    func test_searchController_shouldLoadSearchController() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.searchController)
    }
    
    func test_searchBarDelegate_shouldBeConnected() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.searchController.searchBar.delegate, "search bar delegate")
    }
    
    func test_searchQuery_shouldBeEmpty() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.searchQuery, nil)
    }
    
    func test_navigationSearchController_ShouldBeSearchController() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.navigationItem.searchController, sut.searchController)
    }
    
    func test_searchBarPlaceholderText_ShouldBeSearchMovies() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.searchController.searchBar.placeholder, "Search movies...")
    }
    
    // MARK: - Networking Tests
    
    
}
