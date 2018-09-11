//
//  PhotoZnappTests.swift
//  PhotoZnappTests
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import XCTest
@testable import PhotoZnapp

class PhotoZnappTests: XCTestCase {
    
    func testMakeDateStringReadable() {
        let dateString = "2018-09-09T09:33:45-04:00"
        let displayResult = dateString.makeDateStringReadable()
        XCTAssertEqual(displayResult, "09 September 09:33")
    }
}
