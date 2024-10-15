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
    
    private var mockURLSession: MockURLSession!
    private var movieReviewService: MovieReviewServiceImpl!
    private var sut: CriticsPicksController!

    // MARK: - Setup and Teardown
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        movieReviewService = MovieReviewServiceImpl(session: mockURLSession)
        
        sut = CriticsPicksController(
            collectionView: MovieCollectionView(cell: CriticsPicksCell(), layout: Layout.criticsPicksLayout),
            movieReviewService: movieReviewService
        )
    }

    override func tearDown() {
        mockURLSession = nil
        movieReviewService = nil
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
        
        let apiKey = ArticleSearchAPI.key.value
        
        let request = URLRequest(url: URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=\(apiKey)&fq=section_name:Movies%20AND%20type_of_material:Review%20AND%20kicker:%20(Critic%E2%80%99s%20Pick)&sort=newest&page=0")!)
        
        mockURLSession.verifyDataTask(with: request)
    }
    
    func test_getMoviesNetworkCall_withSuccessfulResponse_shouldSaveDataInCollectionViewMoviesArray() {
        sut.loadViewIfNeeded()
        
        let handleResultsCalled = expectation(description: "handleResults called")
        
        sut.collectionView.handleResults = { _ in
            handleResultsCalled.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(sut.collectionView.movies, [ruleInChileMovieFake])
    }
    
    func test_getMoviesNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInCollectionViewMoviesArray() {
        sut.loadViewIfNeeded()

        mockURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        XCTAssertEqual(sut.collectionView.movies, [])
    }
}
