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
    private var dataService: DataService!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        super.setUp()
        
        sut = CriticsPicksController(
            collectionView: .init(cell: CriticsPicksCell(), layout: Layout.criticsPicksLayout),
            dataService: DataService(session: MockURLSession())
        )
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
        sut.dataService.session = mockURLSession
        let apiKey = ArticleSearchAPI.key.value
        
        let request = URLRequest(url: URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=\(apiKey)&fq=section_name:Movies%20AND%20type_of_material:Review%20AND%20kicker:%20(Critic%E2%80%99s%20Pick)&sort=newest&page=0")!)
        
        sut.getMovies()
        
        mockURLSession.verifyDataTask(with: request)
    }
    
    func test_getMoviesNetworkCall_withSuccessfulResponse_shouldSaveDataInCollectionViewMoviesArray() {
        sut.loadViewIfNeeded()
        
        let formatter = ISO8601DateFormatter()
        
        let mockURLSession = MockURLSession()
        sut.dataService.session = mockURLSession
        
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
                    title: "â€˜The First Yearâ€™ Review: Allendeâ€™s Rule in Chile",
                    isCriticsPick: true,
                    byline: "Devika Girish",
                    summary: "The French-language version of a 1971 documentary by Patricio GuzmÃ¡n is an extraordinary document of a nation in transition.",
                    publicationDate: formatter.date(from: "2023-09-07 15:44:20 +0000"),
                    url: "https://www.nytimes.com/2023/09/07/movies/the-first-year-review.html",
                    image: "https://nytimes.com/images/2023/09/08/multimedia/07first-year-review-pfmw/07first-year-review-pfmw-superJumbo.jpg"
                )
            ]
        )
    }
    
    func test_getMoviesNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInCollectionViewMoviesArray() {
        sut.loadViewIfNeeded()
        
        let mockURLSession = MockURLSession()
        sut.dataService.session = mockURLSession
        
        sut.getMovies()

        mockURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        XCTAssertEqual(sut.collectionView.movies, [])
    }
}
