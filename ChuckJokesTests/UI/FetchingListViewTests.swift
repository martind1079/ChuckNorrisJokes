//
//  FetchingListViewTests.swift
//  ChuckNorrisJokesTests
//
//  Created by Martin Doyle on 13/03/2022.
//

import XCTest
import ViewInspector

@testable import ChuckJokes

class FetchingListViewTests: XCTestCase {
    
    var sut : FetchingListView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = FetchingListView()
    }

    override func tearDownWithError() throws {
        sut = nil
       try super .tearDownWithError()
    }
    
    func testFetchingList_messageTextExists() throws {
       
        let text = try sut!.inspect().vStack().text(0).string()
        XCTAssertNotNil(text)
    }

    func testFetchingList_messageTextHasCorrectMessage() throws {
       
        let text = try sut!.inspect().vStack().text(0).string()
        XCTAssertEqual(text, "Fetching..")
    }

}

extension FetchingListView : Inspectable {}
