//
//  RootViewTests.swift
//  ChuckNorrisJokesTests
//
//  Created by Martin Doyle on 13/03/2022.
//

import XCTest
@testable import ChuckJokes
import ViewInspector

class RootViewTests: XCTestCase {
    
    var sut : RootView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RootView(viewModel: RootViewModel(apiService: APIClient()))
    }

    override func tearDownWithError() throws {
        
        sut = nil
        try super.tearDownWithError()
    }
    
    func testRootView_whenStateIsPresenting_jokesListViewIsShown() {
        
        // given
        sut.viewModel.state = .presenting
        
        do {
            let jokesListView = try sut!.inspect().find(JokesListView.self)
            XCTAssertNotNil(jokesListView)
        } catch {
            XCTFail("View Not Found")
        }
    }
    
    func testRootView_whenStateIsFetching_fetchingListViewIsShown() {
        
        // given
        sut.viewModel.state = .fetchNew
        
        do {
            let fetchingListView = try sut!.inspect().find(FetchingListView.self)
            XCTAssertNotNil(fetchingListView)
        } catch {
            XCTFail("View Not Found")
        }
    }
    
    func testRootView_whenStateIsEmpty_emptyListViewIsShown() {
        
        // given
        sut.viewModel.state = .empty
        
        do {
            let fetchingListView = try sut!.inspect().find(EmptyListView.self)
            XCTAssertNotNil(fetchingListView)
        } catch {
            XCTFail("View Not Found")
        }
    }


}

extension RootView : Inspectable {}
extension JokesListView : Inspectable {}
