//
//  Challenge_1_LabTests.swift
//  Challenge-1-LabTests
//
//  Created by Kevin McQuown on 1/29/21.
//

import XCTest
import Combine

struct Response: Codable {
    var firstNumber: Int
    var secondNumber: Int
    var input: [Int]
}

class Challenge_1_LabTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let expectation = XCTestExpectation(description: "check for duplicates")
        var request = URLRequest(url: URL(string: "http://localhost:3000/hasTwoNumbers")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        var cancellable: Cancellable
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        print("Bad response from server")
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                    print ("Received completion: \(completion).")
                switch completion {
                case .finished:
                    XCTAssertTrue(true)
                    expectation.fulfill()
                case .failure(_):
                    XCTFail()
                    expectation.fulfill()
                }
            }, receiveValue: { value in
                XCTAssertEqual(Lab().findTwoNumbers(input: value.input, addsTo: 2021), value.firstNumber * value.secondNumber)
                expectation.fulfill()
            })
        wait(for: [expectation], timeout: 2.0)
    }

}
