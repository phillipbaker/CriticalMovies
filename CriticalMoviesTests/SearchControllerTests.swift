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
    
    private var mockURLSession: MockURLSession!
    private var movieReviewService: MovieReviewServiceImpl!
    private var sut: SearchController!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        movieReviewService = MovieReviewServiceImpl(session: mockURLSession)
        
        sut = SearchController(
            collectionView: MovieCollectionView(cell: SearchResultCell(), layout: Layout.resultsLayout),
            movieReviewService: movieReviewService,
            searchController: UISearchController(searchResultsController: nil)
        )
    }

    override func tearDown() {
        mockURLSession = nil
        movieReviewService = nil
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
    
    func test_getMoviesNetworkCall_shouldMakeDataTaskToGetSearchResultMovies() {
        let apiKey = ArticleSearchAPI.key.value
        
        sut.loadViewIfNeeded()
        sut.searchQuery = "year"
        sut.getMovies()
        
        let request = URLRequest(url: URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=\(apiKey)&fq=section_name:Movies%20AND%20type_of_material:Review&sort=newest&page=0&q=year")!)

        mockURLSession.verifyDataTask(with: request)
    }
    
    func test_getMoviesNetworkCall_withSuccessfulResponse_shouldSaveDataInCollectionViewMoviesArray() {
        sut.loadViewIfNeeded()
        sut.getMovies()
        
        let handleResultsCalled = expectation(description: "handleResults called")
        
        sut.collectionView.handleResults = { _ in
            handleResultsCalled.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        waitForExpectations(timeout: 0.01)
        
        XCTAssertEqual(sut.collectionView.movies, [ruleInChileMovieFake])
    }
    
    func test_getMoviesNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInCollectionViewMoviesArray() {
        sut.loadViewIfNeeded()
        sut.getMovies()

        mockURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        XCTAssertEqual(sut.collectionView.movies, [])
    }
}
