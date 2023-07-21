//
//  MySuperAppTests.swift
//  MySuperAppTests
//
//  Created by Ghani's Mac Mini on 21/07/2023.
//

import XCTest
@testable import MySuperAppEver

final class MySuperAppEverTests: XCTestCase {

    func testServiceFactoryInt() throws {
        // Given
        let factory = ServiceFactory.shared
        
        // When
        let int = factory.generateInt()
        
        // Then
        XCTAssertEqual(int, 123456789)
    }
    
    func testServiceFactoryString() throws {
        // Given
        let factory = ServiceFactory.shared
        
        // When
        let int = factory.generateString()
        
        // Then
        XCTAssertEqual(int, "String from ServiceFactory")
    }
}
