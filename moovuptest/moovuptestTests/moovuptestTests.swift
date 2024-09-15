//
//  moovuptestTests.swift
//  moovuptestTests
//
//  Created by Max on 11/9/2024.
//

import XCTest
@testable import moovuptest

final class moovuptestTests: XCTestCase {

    func testListViewModel() throws {
        
        let viewModel = ListViewModel()
        
        // API Test
        XCTAssertLessThanOrEqual(viewModel.users.count, 0)
        viewModel.fetchUsers()
        waitUntilisArrayNotNil(viewModel.$users)
        
    }
    
    func testMapViewModel() throws {
        
        let viewModel = MapViewModel()
        
        // API Test
        XCTAssertTrue(viewModel.users.count == 0)
        viewModel.fetchUsers()
        waitUntilisArrayNotNil(viewModel.$users)
        
        // UsersLocation data formatting
        XCTAssertLessThanOrEqual(viewModel.usersLocation.count, 0)
        viewModel.getPeopleOnMap()
        XCTAssertGreaterThan(viewModel.usersLocation.count, 0)
        
    }

}
