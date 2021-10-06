//
//  Structures.swift
//  IOTAPS
//
//  Created by Ivan Lugo on 10/5/21.
//  Copyright © 2021 Shahar Biran. All rights reserved.
//

import Foundation

class LList<NodeValue>: Sequence {
	typealias Node = LNode<NodeValue>
	
	struct Iterator: IteratorProtocol {
		var pointer: Node?
		mutating func next() -> Node? {
			let thisValue = pointer
			pointer = pointer?.next
			return thisValue
		}
	}
	
	var head: Node?
	var tail: Node?
	
	func reset(initialNode: Node?) {
		head = initialNode
		tail = initialNode
	}
	
	func append(_ node: Node) {
		tail?.next = node
		tail = node
	}
	
	func iterate() -> Iterator {
		Iterator(pointer: head)
	}
	
	func makeIterator() -> Iterator {
		Iterator(pointer: head)
	}
}

class LNode<Element> {
	typealias Node = LNode<Element>
	
	var head: Element?
	var element: Element?
	var next: Node?
}
