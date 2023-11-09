//
//  Meal_Search_DemoTests.swift
//  Meal Search DemoTests
//
//  Created by NeoSOFT on 07/11/23.
//

import XCTest
@testable import Meal_Search_Demo

final class Meal_Search_DemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        // Test case to test api response using XCTestExpectation
        let dataProvider = MealRepo()
        let requestParameters = MealCategoriesParameters()
        
        //XCTestExpectation
        let expectation = self.expectation(description: "Fetch Meal Categories")
            dataProvider.getMealCategories(
                requestParameters: requestParameters
            ).done { response in
                XCTAssertTrue(response.categories?.count ?? 0 > 0)
                expectation.fulfill()
            }.catch { error in
                XCTFail("Error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        // Wait for response
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(dataProvider)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
