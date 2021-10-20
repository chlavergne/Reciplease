//
//  RecipeServiceTests.swift
//  RecipleaseTests
//
//  Created by Christophe Expleo on 19/10/2021.
//

import XCTest
@testable import Reciplease
@testable import Alamofire

class RecipeServiceTests: XCTestCase {

    func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeAlamofireSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let recipeService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetchJSON { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeAlamofireSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let recipeService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetchJSON { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeAlamofireSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let recipeService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetchJSON { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetData_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = FakeAlamofireSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let recipeService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetchJSON { result in
            guard case .success(let data) = result else {
                XCTFail("Test getData method with correct data failed.")
                return
            }
            XCTAssertTrue(data[0].label == "Strong Cheese")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
