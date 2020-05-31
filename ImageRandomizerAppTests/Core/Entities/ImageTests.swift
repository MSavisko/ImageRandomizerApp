//
//  ImageTests.swift
//  ImageRandomizerAppTests
//
//  Created by Maksym Savisko on 31.05.2020.
//  Copyright © 2020 Maksym Savisko. All rights reserved.
//

import XCTest
@testable import ImageRandomizerApp

class ImageTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyImage() throws {
        let expected = Image(imageId: "", name: "",
                             imageURL: nil, ratio: 0.0)
        
        XCTAssertEqual(Image.empty, expected)
    }
}
