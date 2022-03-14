//
//  JokeViewModelTests.swift
//  JokeViewModelTests
//
//  Created by Martin Doyle on 12/03/2022.
//

import XCTest
@testable import ChuckJokes

class JokeViewModelTests: XCTestCase {
    
    var sut : JokeViewModel!

    override func setUpWithError() throws {
        
        sut = JokeViewModel()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
       sut = nil
        try super.tearDownWithError()
    }
    
    func testJokeViewModel_givenHTMLString_SpecialCharactersAreRemoved() {
        
        let inputString = "Ampersand &amp; Apostraphe &apos; GreaterThan &gt; LessThan &lt; Quotation &quot;"
        let expectedResultString = "Ampersand & Apostraphe ' GreaterThan > LessThan < Quotation '"
        
        let testString = sut.formatJoke(inputString)
        
        XCTAssertEqual(testString, expectedResultString)
    }

   

}
