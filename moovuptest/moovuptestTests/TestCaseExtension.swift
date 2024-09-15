//
//  TestCaseExtension.swift
//  moovuptestTests
//
//  Created by Max on 16/9/2024.
//

import XCTest
import Combine
@testable import moovuptest

extension XCTestCase {
    
    func waitUntilAnyPublisherSuccess<T>(
        _ propertyPublisher: AnyPublisher<T, Error>,
        timeout: TimeInterval = 6,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let expectation = expectation(
            description: "AnyPublisher in error"
        )
        
        var cancellable: AnyCancellable?
        
        cancellable = propertyPublisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { error in
                    if case .failure(_) = error {
                        XCTAssertTrue(false)
                    }
                    XCTAssertTrue(true)
                    cancellable?.cancel()
                    expectation.fulfill()
                },
                receiveValue: { _ in }
            )

//        waitForExpectations(timeout: timeout, handler: nil)
        wait(for: [expectation], timeout: timeout)
    }
    func waitUntil<T: Equatable>(
        _ propertyPublisher: Published<T>.Publisher,
        equals expectedValue: T,
        timeout: TimeInterval = 6,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let expectation = expectation(
            description: "Awaiting value \(expectedValue)"
        )
        
        var cancellable: AnyCancellable?

        cancellable = propertyPublisher
            .dropFirst()
            .first(where: { $0 == expectedValue })
            .sink { value in
                XCTAssertEqual(value, expectedValue, file: file, line: line)
                cancellable?.cancel()
                expectation.fulfill()
            }

//        waitForExpectations(timeout: timeout, handler: nil)
        wait(for: [expectation], timeout: timeout)
    }
    
    func waitUntilisNotNil<T: Equatable>(
        _ propertyPublisher: Published<T>.Publisher,
        timeout: TimeInterval = 6,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let nilExpectation = self.expectation(description: "Awaiting value is Nil")
        
        var cancellable: AnyCancellable?
        
        cancellable = propertyPublisher
            .dropFirst()
            .compactMap{ $0 }
            .sink { value in
                XCTAssertNotNil(value, file: file, line: line)
                cancellable?.cancel()
                nilExpectation.fulfill()
            }

//        waitForExpectations(timeout: timeout, handler: nil)
        wait(for: [nilExpectation], timeout: timeout)
    }
    
    func waitUntilisArrayNotNil<T>(
        _ propertyPublisher: Published<[T]>.Publisher,
        timeout: TimeInterval = 6,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let nilExpectation = self.expectation(description: "Awaiting array is Nil")
        
        var cancellable: AnyCancellable?
        
        cancellable = propertyPublisher
            .dropFirst()
            .compactMap{ $0 }
            .sink { value in
                XCTAssertGreaterThan(value.count, 0, file: file, line: line)
                cancellable?.cancel()
                nilExpectation.fulfill()
            }

//        waitForExpectations(timeout: timeout, handler: nil)
        wait(for: [nilExpectation], timeout: timeout)
    }
    
    func waitUntilisNotNil<T1: Equatable, T2: Equatable>(
        _ propertyPublisher1: Published<T1>.Publisher,
        _ propertyPublisher2: Published<T2>.Publisher,
        timeout: TimeInterval = 6,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let nilExpectation = self.expectation(description: "Awaiting value is Nil")
        
        var cancellable: AnyCancellable?
        
        cancellable = Publishers.Zip(propertyPublisher1, propertyPublisher2)
            .dropFirst()
            .compactMap{ $0 }
            .sink { value1, value2 in
                XCTAssertNotNil(value1, file: file, line: line)
                XCTAssertNotNil(value2, file: file, line: line)
                cancellable?.cancel()
                nilExpectation.fulfill()
            }

//        waitForExpectations(timeout: timeout, handler: nil)
        wait(for: [nilExpectation], timeout: timeout)
    }
}

extension XCTestCase {
    func runAsyncTest(
        named testName: String = #function,
        in file: StaticString = #file,
        at line: UInt = #line,
        withTimeout timeout: TimeInterval = 10,
        test: @escaping () async throws -> Void
    ) {
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }
        let expectation = expectation(description: testName)

        Task {
            do {
                try await test()
            } catch {
                errorHandler(error)
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: timeout)

        if let error = thrownError {
            XCTFail(
                "Async error thrown: \(error)",
                file: file,
                line: line
            )
        }
    }
}
