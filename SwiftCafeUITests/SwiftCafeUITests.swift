//
//  SwiftCafeUITests.swift
//  SwiftCafeUITests
//
//  Created by Jason Tse on 10/7/2025.
//

import XCTest

final class SwiftCafeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testLoginViewElementsExist() throws {
        // Arrange
        
        // Act
        
        // Assert
        XCTAssertTrue(app.textFields["Email"].exists)
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
    }
    
    @MainActor
    func testCompleteLoginFlow() throws {
        // Arrange
        let emailTextField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Login"]
        let username = "emilys"
        let password = "emilyspass"
        
        let timeout = 5.0
        
        // Act
        emailTextField.tap()
        emailTextField.clearText()
        emailTextField.typeText(username)
        
        passwordField.tap()
        passwordField.clearText()
        passwordField.typeText(password)
        
        loginButton.tap()
        
        // Assert
        XCTAssertTrue(app.textFields["Email"].waitForNonExistence(timeout: timeout))
        XCTAssertTrue(app.secureTextFields["Password"].waitForNonExistence(timeout: timeout))
        XCTAssertTrue(app.buttons["Login"].waitForNonExistence(timeout: timeout))
        XCTAssertTrue(app.staticTexts["Swift Cafe"].waitForNonExistence(timeout: timeout))
        
        XCTAssertTrue(app.navigationBars["Menu"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
}
