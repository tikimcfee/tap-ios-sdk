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

	private var head: Node?
	private var tail: Node?
	
	func append(_ value: NodeValue) {
		listAppend(LNode(value))
	}
	
	private func listAppend(_ node: Node) {
		if head == nil {
			head = node
		}
		tail?.next = node
		tail = node
	}
	
	func makeIterator() -> LLIterator {
		LLIterator(pointer: head)
	}
}

extension LList {
	struct LLIterator: IteratorProtocol {
		var pointer: Node?
		mutating func next() -> NodeValue? {
			let thisValue = pointer
			pointer = pointer?.next
			return thisValue?.element
		}
	}
}

class LNode<Element> {
	typealias Node = LNode<Element>
	var element: Element?
	var next: Node?
	init(_ element: Element) {
		self.element = element
	}
}
