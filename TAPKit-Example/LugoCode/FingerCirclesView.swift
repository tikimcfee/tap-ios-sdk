//
//  FingerCirclesView.swift
//  TAPKit-Example
//
//  Created by Ivan Lugo on 10/4/21.
//  Copyright © 2021 Shahar Biran. All rights reserved.
//

import UIKit

class FingerCirclesView: UIView {
	
	lazy var stack: UIStackView = makeStackView()
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	private func setup() {
		
	}
}

extension FingerCirclesView {
	func makeStackView() -> UIStackView {
		let view = UIStackView()
		view.axis = .horizontal
		view.alignment = .center
		view.spacing = 8.0
		view.distribution = .fill
		return view
	}
	
	func makeCircleView() -> UIView {
		let view = UIView()
		return view
	}
}
