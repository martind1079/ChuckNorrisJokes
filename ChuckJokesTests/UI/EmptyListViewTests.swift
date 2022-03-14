//
//  EmptyListViewTests.swift
//  ChuckNorrisJokesTests
//
//  Created by Martin Doyle on 13/03/2022.
//



import XCTest
import ViewInspector

@testable import ChuckJokes

class EmptyListViewTests: XCTestCase {
    
    var sut : EmptyListView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = EmptyListView(viewModel: RootViewModel(apiService: APIClient()))
    }

    override func tearDownWithError() throws {
       sut = nil
        try super.tearDownWithError()
    }
    
    func testEmptyList_messageTextExists() throws {
       
        let text = try sut!.inspect().vStack().text(0).string()
        XCTAssertNotNil(text)
    }

    func testEmptyList_messageTextHasCorrectMessage() throws {
       
        let text = try sut!.inspect().vStack().text(0).string()
        XCTAssertEqual(text, "No Jokes Available :(")
    }
    
    func testEmptyList_buttonWithCorrectTitleExists() throws {
       
        let button = try sut!.inspect().find(button: "Fetch More Jokes!")
        XCTAssertNotNil(button)
    }

}

extension EmptyListView : Inspectable {}
