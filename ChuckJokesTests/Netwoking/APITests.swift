//
//  APITests.swift
//  ChuckNorrisJokesTests
//
//  Created by Martin Doyle on 12/03/2022.
//

import XCTest
@testable import ChuckJokes

import OHHTTPStubs
import OHHTTPStubsSwift
import Combine

class APITests: XCTestCase {
    
    var subscriptions : Set<AnyCancellable> = []
    var stubsDescriptors : [HTTPStubsDescriptor] = []
    var sut : APIClient!

    override func setUpWithError() throws {
        sut = APIClient()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        stubsDescriptors.forEach({
            HTTPStubs.removeStub($0)
        })
        sut = nil
        try super.tearDownWithError()
    }
    
    func testAPIClient_fetchingSucceeds() {
        
        let stubsDescriptor = stubAPI(success: true, stubPath: "Jokes.json")
        
        stubsDescriptors.append(stubsDescriptor)
        
        let expectation = self.expectation(description: "Fetch Jokes")
        
        sut.fetchJokes().sink(receiveCompletion: {
            completion in
            
            switch completion {
            case .finished :
                expectation.fulfill()
            case .failure:
                
                XCTFail("Should have succeeded")
            }
            
        }, receiveValue: {
            
            jokes in
            
            XCTAssertEqual(jokes.count, 5)
            
        }).store(in: &subscriptions)
        
        waitForExpectations(timeout: 5)
        
    }
    
    func testAPIClient_fetchingFails() {
        
        let stubsDescriptor = stubAPI(success: false, stubPath: "")
        
        stubsDescriptors.append(stubsDescriptor)
        
        let expectation = self.expectation(description: "Fetch Jokes")
        
        sut.fetchJokes().sink(receiveCompletion: {
            completion in
            
            switch completion {
            case .finished :
                XCTFail("Should have succeeded")
            case .failure:
                expectation.fulfill()
            }
            
        }, receiveValue: {
            
            jokes in
            
            XCTFail("Request should have failed")
            
        }).store(in: &subscriptions)
        
        waitForExpectations(timeout: 5)
        
    }
    
    
    func testAPIClient_whenResponseHasExplicitJokes_theyAreRemoved() {
        
        let stubsDescriptor = stubAPI(success: true, stubPath: "TwoExplicitJokes.json")
        
        stubsDescriptors.append(stubsDescriptor)
        
        let expectation = self.expectation(description: "Fetch Jokes")
        
        sut.fetchJokes().sink(receiveCompletion: {
            completion in
            
            switch completion {
            case .finished :
                expectation.fulfill()
            case .failure:
                
                XCTFail("Should have succeeded")
            }
 
        }, receiveValue: {
            
            jokes in
            // filtered out two from the 5 leaving 3
            XCTAssertEqual(jokes.count, 3)
            
        }).store(in: &subscriptions)
        
        waitForExpectations(timeout: 10)
        
    }
}

extension XCTest {
    
    func stubAPI(success: Bool, stubPath: String) -> HTTPStubsDescriptor {
        stub(condition: {
            request in
            request.url?.path == "/jokes/random/5"
        }, response: {
            request in
            
            if success {
                if let filePath = OHPathForFile(stubPath, type(of: self)) {
                    return fixture(filePath: filePath, status: 200, headers: [:])
                } else {
                    fatalError("Unable To find stub in bundle")
                }
            } else {
                return HTTPStubsResponse(data: Data(), statusCode: 401, headers: [:])
            }
        })
    }
    
}
