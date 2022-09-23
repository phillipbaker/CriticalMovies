//
//  MockURLSession.swift
//  CriticalMoviesTests
//
//  Created by Phillip Baker on 8/18/22.
//

import Foundation
import XCTest
@testable import CriticalMovies

final class MockURLSession: URLSessionProtocol {
        
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    var dataTaskArgsCompletionHandler: [(Data?, URLResponse?, Error?) -> Void] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        dataTaskArgsCompletionHandler.append(completionHandler)
        
        return DummyURLSessionDataTask()
    }
    
    func verifyDataTask(with request: URLRequest, file: StaticString = #file, line: UInt = #line) {
        guard dataTaskWasCalledOnce(file: file, line: line) else { return }
        
        XCTAssertEqual(dataTaskArgsRequest.first, request, "request", file: file, line: line)
    }
    
    private func dataTaskWasCalledOnce(file: StaticString = #file, line: UInt = #line) -> Bool {
        verifyMethodCalledOnce(
            methodName: "dataTask(with:completionHandler:)",
            callCount: dataTaskCallCount,
            describeArguments: "request: \(dataTaskArgsRequest)",
            file: file,
            line: line
        )
    }
}

private class DummyURLSessionDataTask: URLSessionDataTask {
    override func resume() {}
}

func verifyMethodCalledOnce(
    methodName: String,
    callCount: Int,
    describeArguments: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line) -> Bool {
        if callCount == 0 {
            XCTFail("wanted but not invoked: \(methodName)", file: file, line: line)
            return false
        }
        if callCount > 1 {
            XCTFail("Wanted 1 time but was called \(callCount) times. " + "\(methodName) with \(describeArguments())", file: file, line: line)
            return false
        }
        
        return true
    }
