//
//  MySuperAppEverUITests.swift
//  MySuperAppEverUITests
//
//  Created by Ghani's Mac Mini on 21/07/2023.
//

import XCTest

final class MySuperAppEverUITests: XCTestCase {
    func testPresentListModal() throws {
        let app = XCUIApplication()
        app.launch()
        
        let presentListMobalButton = app.buttons["Present List Modal"]
        XCTAssertTrue(presentListMobalButton.exists)
        app.buttons["Present List Modal"].tap()
        
        let titleLabel = app.staticTexts["This gonna be my super app 🚀"]
        XCTAssertTrue(titleLabel.exists)
        
        let dismissButton = app.buttons["Dismiss"]
        XCTAssertTrue(dismissButton.exists)
        dismissButton.tap()
        
        XCTAssertTrue(presentListMobalButton.exists)
    }
}
