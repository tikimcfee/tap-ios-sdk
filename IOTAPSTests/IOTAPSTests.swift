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
		
		var iterator = list.makeIterator()
		while iterator.next() != nil { _ = iterator.next() }
		let newString = "New string after consuming"
		list.append(newString)
		let final = iterator.next()
		XCTAssertEqual(newString, final, "Iterator did not keep up with list's updates")
		
		let multipleNewStrings = ["So long", "farewell", "goodbye"]
		multipleNewStrings.forEach { list.append($0) }
		var liveIteratorStrings = [String]()
		while let newString = iterator.next() {
			liveIteratorStrings.append(newString)
		}
		XCTAssertEqual(multipleNewStrings, liveIteratorStrings, "Live iterator failed after multiple elements")
		
		list.removeAll()
		let emptyList = list.map { $0 }
		XCTAssertTrue(emptyList.isEmpty, "removeAll did not clear linked list")
	}
	
	func testSensorState() throws {
		let sensorState = RawSensorState()
	}
	
}
