//
//  FingerDataView.swift
//  TAPKit-Example
//
//  Created by Ivan Lugo on 10/4/21.
//  Copyright © 2021 Shahar Biran. All rights reserved.
//

import UIKit
import TAPKit

class FingerDataView: UIView {
	
	private lazy var stack: UIStackView = makeStackView()
	private lazy var dataStacks: [Fingers: UIView] = makeStacksDictionary()
	var ordering: Ordering = .thumbOnRight
	
	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		updateLayerDisplays()
	}
	
	private func updateLayerDisplays() {
		stack.arrangedSubviews.forEach {
			// oddly enough, if you don't set the layer's frame during an (initial?) update, you'll sometimes
			// end up with a layer who's frame is out of sync with the view's: sizes are off, probably positions too.
			// this is likely something to do with constraints and auto-layout timing.
			// alternately, there's a better place to request layer updates than 'layoutSubview()'
			$0.layer.frame = $0.bounds
			$0.layer.cornerRadius = $0.frame.width / 2.0
			$0.clipsToBounds = true
		}
	}
	
	private func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		addSubview(stack)
		ordering.fingers.forEach { finger in
			guard let view = dataStacks[finger] else { return }
			stack.addArrangedSubview(view)
			
			NSLayoutConstraint.activate([
				view.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.18),
				view.heightAnchor.constraint(equalTo: view.widthAnchor)
			])
		}
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: leadingAnchor),
			stack.trailingAnchor.constraint(equalTo: trailingAnchor),
			stack.topAnchor.constraint(equalTo: topAnchor),
			stack.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
		displayFingers([])
	}
	
	func displayFingers(_ newTaps: [Fingers]) {
		
	}
	
	private func fingerView(_ finger: Fingers, _ action: (UIView) -> Void) {
		if let view = dataStacks[finger] {
			action(view)
		}
	}
}

extension FingerDataView {
	func makeStackView() -> UIStackView {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.alignment = .center
		view.spacing = 8.0
		view.distribution = .equalSpacing
		return view
	}
	
	func makeStacksDictionary() -> [Fingers: UIView] {
		ordering.fingers.reduce(into: [:]) { result, finger in 
			result[finger] = makeCircleView()
		}
	}
	
	func makeCircleView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}
}
