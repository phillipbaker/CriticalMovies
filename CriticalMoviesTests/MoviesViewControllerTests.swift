//
//  CriticalMoviesTests.swift
//  MoviesViewControllerTests
//
//  Created by Phillip Baker on 9/27/21.
//

@testable import CriticalMovies
import XCTest

class MoviesViewControllerTests: XCTestCase {
    
    private var sut: BrowseViewController!
    
    override func setUp() {
        super.setUp()
        sut = BrowseViewController()
        let mockLayout = UICollectionViewLayout()
        sut.collectionView = UICollectionView(frame: .zero, collectionViewLayout: mockLayout)
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop() // Clean out UIWindow
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_navigationBar_shouldHaveTitle() {
        XCTAssertEqual(sut.navigationItem.title, "NYT Critic’s Picks")
    }
    
    func test_collectionView_shouldBeConnected() {
        XCTAssertNotNil(sut.collectionView)
    }
    
    func test_dataSource_shouldBeConnected() {
        XCTAssertNotNil(sut.dataSource)
    }
    
    func test_collectionView_shouldGenerateLayout() {
        XCTAssertNotNil(sut.collectionView.collectionViewLayout)
    }
    
    func test_collectionView_recentMovieReviews_shouldPageByGroup() {
//        XCTAssertTrue(sut.collectionView.)
    }

}
