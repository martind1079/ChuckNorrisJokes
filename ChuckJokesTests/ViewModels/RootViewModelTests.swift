//
//  RootViewModelTests.swift
//  ChuckNorrisJokesTests
//
//  Created by Martin Doyle on 13/03/2022.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
import Combine

@testable import ChuckJokes

class RootViewModelTests: XCTestCase {
    
    var subscriptions : Set<AnyCancellable> = []
    var stubsDescriptors : [HTTPStubsDescriptor] = []
    var sut : RootViewModel!
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RootViewModel(apiService: APIClient())
    }

    override func tearDownWithError() throws {
        stubsDescriptors.forEach({
            HTTPStubs.removeStub($0)
        })
        sut.stateChangedCallback = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testRootVM_whenFetchingJokes_stateIsFetching() {
        
        let stubsDescriptor = stubAPI(success: false, stubPath: "")
        
        stubsDescriptors.append(stubsDescriptor)
        
        let expectation = self.expectation(description: "Failed Fetch State = empty")
        
        sut.stateChangedCallback = {
            viewModel in
            
            XCTAssertEqual(viewModel.state, .fetchNew)
            expectation.fulfill()
            
        }
        
        sut.fetchJokes()
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testRootVM_whenFetchingFails_stateIsEmpty() {
        
        let stubsDescriptor = stubAPI(success: false, stubPath: "")
        
        stubsDescriptors.append(stubsDescriptor)
        
        let expectation = self.expectation(description: "Failed Fetch State = empty")
        
        sut.stateChangedCallback = {
            viewModel in
            
            guard viewModel.state != .fetchNew else {  // ignore the fetching state in this case
                return
            }
            
            XCTAssertEqual(viewModel.state, .empty)
            expectation.fulfill()
            
        }
        
        sut.fetchJokes()
        
        wait(for: [expectation], timeout: 5)
        
    }
    
    func testRootVM_whenFetchingSucceeds_stateIsPresenting() {
        
        let stubsDescriptor = stubAPI(success: true, stubPath: "Jokes.json")
        
        stubsDescriptors.append(stubsDescriptor)
        
        let expectation = self.expectation(description: "Success Fetch State = presenting")
        
        sut.stateChangedCallback = {
            viewModel in
            
            guard viewModel.state != .fetchNew else {  // ignore the fetching state in this case
                return
            }
            
            XCTAssertEqual(viewModel.state, .presenting)
            expectation.fulfill()
            
        }
        
        sut.fetchJokes()
        
        wait(for: [expectation], timeout: 5)
        
    }


}
