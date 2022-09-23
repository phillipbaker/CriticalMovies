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
    
    override func setUp() {
        super.setUp()
        sut = CriticsPicksController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - View Controller Tests
    
    func test_criticsPicksController_shouldLoad() {
        XCTAssertNotNil(sut)
    }
    
    func test_navigationTitle_shouldBeCriticsPicks() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.navigationItem.title, "Critics’ Picks")
    }
    
    func test_navigationTitle_shouldPreferLargeTitles() {
        guard let navigationController = sut.navigationController else {
            print("navigation controller is nil")
            return
        }
        
        XCTAssert(navigationController.navigationBar.prefersLargeTitles == true)
    }
    
    // MARK: - Collection View Tests
    
    func test_criticsPicksController_shouldCreateCollectionView() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.collectionView)
    }
    
    func test_criticsPicksController_shouldAddChildCollectionView() {
        XCTAssertNotNil(sut.children)
    }
    
    func test_criticsPicksController_shouldConnectCollectionViewDelegate() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.collectionView.delegate, "collection view delegate")
    }
    
    func test_criticsPicksController_shouldConnectCollectionViewDataSource() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.collectionView.dataSource, "collection view dataSource")
    }
    
    func test_collectionViewLayout_shouldBeCriticsPicksLayout() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.collectionView.layout, Layout.criticsPicksLayout)
    }
    
    // MARK: - Networking Tests
    
    func test_getMoviesNetworkCall_shouldMakeDataTaskToGetCriticsPicksMovies() {
        sut.loadViewIfNeeded()
        
        let mockURLSession = MockURLSession()
        sut.movieReviewService.session = mockURLSession
        
        let request = URLRequest(url: URL(string: "https://api.nytimes.com/svc/movies/v2/reviews/picks.json?api-key=7mZQQ5atRHInAGiRitXjfpiNhKqgCIKj&offset=0")!)
        
        sut.getMovies()
        
        mockURLSession.verifyDataTask(with: request)
    }
    
    func test_getMoviesNetworkCall_withSuccessfulResponse_shouldSaveDataInCollectionViewMoviesArray() {
        sut.loadViewIfNeeded()
        
        let mockURLSession = MockURLSession()
        sut.movieReviewService.session = mockURLSession
        
        sut.getMovies()
        
        let handleResultsCalled = expectation(description: "handleResults called")
        
        sut.collectionView.handleResults = { _ in
            handleResultsCalled.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(
            sut.collectionView.movies, [
                Movie(
                    title: "Stay on Board: The Leo Baker Story",
                    criticsPick: 1,
                    byline: "Teo Bugbee",
                    headline: "‘Stay on Board: The Leo Baker Story’ Review: Surviving the Grind",
                    summary: "In this documentary, a professional skateboarder turns down the Olympics for the chan  to live openly.",
                    publicationDate: "2022-08-11",
                    link: Link(reviewUrl: "https://www.nytimes.com/2022/08/11/movies/stay-on-board-the-leo-baker-story-review.html"),
                    multimedia: Multimedia(imageUrl: "https://static01.    .com/images/2022/08/12/arts/11leo-baker-review1/11leo-baker-review1-mediumThreeByTwo440.jpg")
                )
            ]
        )
    }
    
    func test_getMoviesNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInCollectionViewMoviesArray() {
        sut.loadViewIfNeeded()
        
        let mockURLSession = MockURLSession()
        sut.movieReviewService.session = mockURLSession
        
        sut.getMovies()

        mockURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        XCTAssertEqual(sut.collectionView.movies, [])
    }
}
