//
//  CriticsPicksControllerTests.swift
//  CriticalMoviesTests
//
//  Created by Phillip Baker on 1/31/22.
//

@testable import CriticalMovies
import XCTest

class CriticsPicksControllerTests: XCTestCase {
    // MARK: - Properties
    
    private var sut: CriticsPicksController!
    
    // MARK: - Setup and Teardown
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CriticsPicksController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests
    
    func test_criticsPicksController_shouldLoad() {
        XCTAssertNotNil(sut)
    }
    
    func test_criticsPicksController_shouldCreateCollectionView() {
        XCTAssertNotNil(sut.collectionView)
    }
    
    func test_criticsPicksController_shouldAddChildCollectionView() {
        XCTAssertNotNil(sut.children)
    }
    
    func test_navigationTitle_shouldBeCriticsPicks() {
        XCTAssertEqual(sut.navigationItem.title, "Critics’ Picks")
    }
    
    func test_navigationTitle_shouldPreferLargeTitles() {
        guard let navigationController = sut.navigationController else {
            print("navigation controller is nil")
            return
        }
        
        XCTAssert(navigationController.navigationBar.prefersLargeTitles == true)
    }
    
    func test_collectionViewLayout_shouldBeCriticsPicksLayout() {
        XCTAssert(sut.collectionView.layout == Layout.criticsPicksLayout)
    }
    
    func test_collectionViewDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.collectionView.delegate, "collection view delegate")
        XCTAssertNotNil(sut.collectionView.dataSource, "collection view dataSource")
    }
}
