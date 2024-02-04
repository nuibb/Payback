//
//  PaybackTests.swift
//  PaybackTests
//
//  Created by Nurul Islam on 29/1/24.
//

import XCTest
@testable import WorldOfPAYBACK

final class PaybackTests: XCTestCase {
    var mockDataProvider: MockDataProvider!
    
    override func setUpWithError() throws {
        mockDataProvider = MockDataProvider()
    }
    
    override func tearDownWithError() throws {
        mockDataProvider = nil
    }
    
    func test_TransactionListViewModel_when_network_is_unavailable() async {
        // ARRANGE
        let expectation = XCTestExpectation(description: "Network error expectation")
        mockDataProvider.networkMonitor.isConnected = false // Set the network to be unavailable
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response = await mockDataProvider.fetchTransactions()
            if case .success(let data) = response {
                XCTFail("Expected network to be unavailable")
            } else if case .failure(let error) = response {
                XCTAssertEqual(error.description, RequestError.networkNotAvailable.description)
                expectation.fulfill()
            } else {
                XCTFail("Expected network to be unavailable")
            }
        }
        
        // ASSERT
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func test_TransactionListViewModel_fetching_transactions_successful() async {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch Transactions")
        mockDataProvider.networkMonitor.isConnected = true
        
        do {
            /// Ensure network connectivity for real API call
            try XCTSkipUnless(mockDataProvider.networkMonitor.isConnected, "Network connectivity needed for this test.")
        } catch {
            XCTFail("Skipping test due to lack of network connectivity: \(error)")
            return
        }
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response = await mockDataProvider.fetchTransactions()
            if case .success(let data) = response {
                if !data.items.isEmpty {
                    XCTAssertFalse(data.items.isEmpty, "Fetching transactions is successful!")
                    XCTAssertGreaterThan(data.items.count, 0)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetching transactions failed")
                }
            } else if case .failure(let error) = response {
                XCTFail("Fetching transactions failed")
            } else {
                XCTFail("Fetching transactions failed")
            }
        }
        
        // ASSERT
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func test_TransactionListViewModel_fetching_transactions_empty() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch Transactions: response is empty")
        let dummyUrl = "https://api-test.payback.com/transactions"
        let json = """
        {
            "items": []
        }
        """
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response: Swift.Result<Transactions, RequestError> = self.fakeApiRequest(
                for: dummyUrl,
                statusCode: 200,
                responseData: json.data(using: .utf8)!)
            if case .success(let data) = response {
                if data.items.isEmpty {
                    XCTAssertTrue(data.items.isEmpty, "Fetching transactions is empty!")
                    XCTAssertEqual(data.items.count, 0)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetch Transactions: response isn't empty")
                }
            } else if case .failure(let error) = response {
                XCTFail("Fetch Transactions: response isn't empty")
            } else {
                XCTFail("Fetch Transactions: response isn't empty")
            }
        }
        
        // ASSERT
        wait(for: [expectation], timeout: 5)
    }
    
    func test_TransactionListViewModel_fetching_transactions_unsuccessful_by_random() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch Transactions: unauthorised response")
        let dummyUrl = "https://api-test.payback.com/transactions"
        let delay = Int.random(in: 1...2)
        
        // ACT
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(delay)) {
            let shouldFail = Bool.random()
            
            if shouldFail {
                let response: Swift.Result<Transactions, RequestError> = self.fakeApiRequest(
                    for: dummyUrl,
                    statusCode: 401)
                if case .success(let data) = response {
                    XCTFail("Fetching Transactions should be failed!")
                } else if case .failure(let error) = response {
                    XCTAssertEqual(error.description, RequestError.unauthorized.description)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetching Transactions should be failed!")
                }
            } else {
                XCTFail("Fetching Transactions should be failed!")
            }
        }
        
        // ASSERT
        wait(for: [expectation], timeout: 5)
    }
    
    // Fake API REQUEST to test
    private func fakeApiRequest<T: Decodable>(
        for url: String,
        statusCode: Int,
        responseData: Data? = nil) -> Swift.Result<T, RequestError> {
            guard let response = HTTPURLResponse(
                url: URL(string: url)!,
                statusCode: statusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil) else { return .failure(.noResponse) }
            
            switch response.statusCode {
            case 200...299:
                if let data = responseData {
                    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                        return .failure(.decode)
                    }
                    return .success(decodedResponse)
                } else {
                    return .failure(.custom("No data available to parse!"))
                }
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unknown)
            }
        }
}
