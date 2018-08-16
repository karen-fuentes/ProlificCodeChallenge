//
//  prolificCodeChallengeTests.swift
//  prolificCodeChallengeTests
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import XCTest
@testable import prolificCodeChallenge

class prolificCodeChallengeTests: XCTestCase {
    
    var bookAPIClientUnderTest: BooksAPIClient!
    var apiManagerUnderTest: APIRequestManager!
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        bookAPIClientUnderTest = nil
        apiManagerUnderTest = nil
        super.tearDown()
    }
    
    func testingDateToString() {
        //arrange
        let date = "2018-08-16 17:25:27"
        let expectedDate = "Aug 16, 2018   1:25PM"
        //action
        let result = date.dateStringToReadableString()
        //assert
        XCTAssertTrue(expectedDate == result)
    }

    //testing asychronous calls: Success fast, failure slow
    func testValidCallToProlificGetsHTTPStatusCode200() {
            //arrange
            let url = URL(string: "http://prolific-interview.herokuapp.com/5b6e0136eff04800097ca206/books/")
            let promise = expectation(description: "Status code: 200")
            //act
            let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
                if let error = error {
                    //Assert
                    XCTFail("Error: \(error.localizedDescription)")
                    return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if statusCode == 200 {
                        promise.fulfill()
                    } else {
                        XCTFail("Status code: \(statusCode)")
                    }
                }
            }
            dataTask.resume()
            waitForExpectations(timeout: 5, handler: nil)
        }
}
