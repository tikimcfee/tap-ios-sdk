//
//  TestingTaps.swift
//  TestingTaps
//
//  Created by Ivan Lugo on 10/4/21.
//  Copyright © 2021 Shahar Biran. All rights reserved.
//

import XCTest
@testable import IOTAPS

class TestingTaps: XCTestCase {
	
	override func setUpWithError() throws {
		
	}
	
	override func tearDownWithError() throws {
		
	}
	
	func testLinkedList() throws {
		let testStrings = ["hello", "one", "two", "three", "four"]
		
		let list = LList<String>()
		testStrings.forEach {
			list.append($0)
		}
		
		let readBackList = list.map { $0 }
		XCTAssertEqual(testStrings, readBackList, "Lists did not match")
		
		let readBackListAgain = list.map { $0 }
		XCTAssertEqual(testStrings, readBackListAgain, "Lists did not match on second read")
	}
	
}
