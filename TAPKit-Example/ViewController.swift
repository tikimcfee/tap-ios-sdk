//
//  ViewController.swift
//  TAPKit-Example
//
//  Created by Shahar Biran on 08/04/2018.
//  Copyright © 2018 Shahar Biran. All rights reserved.
//

import UIKit
import TAPKit
import AppKit

class ViewController: UIViewController {
	
	private lazy var tapDelegate: TAPKitDelegate = makeTestDelegate()
	
	private lazy var circlesView = FingerCirclesView()
	private lazy var controls = makeButtonsView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        TAPKit.sharedKit.addDelegate(tapDelegate)
        TAPKit.log.disable(event: .warning)
        TAPKit.log.enableAllEvents()
        TAPKit.sharedKit.start()
        // let taps = TAPKit.sharedKit.getConnectedTaps()
		
		view.addSubview(circlesView)
		view.addSubview(controls)
		NSLayoutConstraint.activate([
			circlesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			circlesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			circlesView.topAnchor.constraint(equalTo: view.topAnchor),
			circlesView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
//			controls.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: +16.0),
			controls.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +16.0),
			controls.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0),
		])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TAPKit.sharedKit.removeDelegate(tapDelegate)
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func TEST__flashRandomFingers() {
		circlesView.displayFingers([Fingers.allCases.randomElement()!, Fingers.allCases.randomElement()!])
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: TEST__flashRandomFingers)
	}
	
	private func makeTestDelegate() -> TAPKitDelegate {
		let delegate = StartingTapDelegate()
		delegate.tapUpdates = { [weak self] fingers in
			self?.enqueueUpdate(fingers)
		}
		return delegate	
	}
	
	private func enqueueUpdate(_ fingers: [Fingers]) {
		DispatchQueue.global(qos: .userInitiated).async { [weak circlesView, fingers] in 
			DispatchQueue.main.async {
				circlesView?.displayFingers(fingers)
			}
		}
	}
	
	private func makeButtonsView() -> UIStackView {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .center
		stack.distribution = .fillEqually
		stack.spacing = 16.0
		stack.layer.borderColor = .init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
		stack.layer.borderWidth = 2.0
		stack.layer.cornerRadius = 4.0
		stack.directionalLayoutMargins = .init(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
		stack.layoutMargins = .init(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
		stack.isLayoutMarginsRelativeArrangement = true
		stack.addArrangedSubview(buttonSetModeToRaw())
		stack.addArrangedSubview(buttonSetModeToKeyboard())
		stack.addArrangedSubview(buttonSetModeToController())
		stack.addArrangedSubview(buttonSetModeToControllerMouseHID())
		stack.arrangedSubviews.forEach { button in 
			NSLayoutConstraint.activate([
				button.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 4.0),
				button.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -4.0),
			])
			button.layer.borderColor = .init(red: 0.2, green: 0.2, blue: 0.4, alpha: 0.8)
			button.layer.borderWidth = 2.0
			button.layer.cornerRadius = 4.0
			
		}
		return stack
	}
	
	private func buttonSetModeToRaw() -> UIButton {
		let button = UIButton()
		button.setTitle("Set to RAW", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.addTarget(self, action: #selector(onButtonSetToRawTapped), for: .touchUpInside)
		return button
	}
	
	private func buttonSetModeToKeyboard() -> UIButton {
		let button = UIButton()
		button.setTitle("Set to Keyboard ('text')", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.addTarget(self, action: #selector(onButtonSetToKeyboardTapped), for: .touchUpInside)
		return button
	}
	
	private func buttonSetModeToController() -> UIButton {
		let button = UIButton()
		button.setTitle("Set to Controller", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.addTarget(self, action: #selector(onButtonSetToControllerTapped), for: .touchUpInside)
		return button
	}
	
	private func buttonSetModeToControllerMouseHID() -> UIButton {
		let button = UIButton()
		button.setTitle("Set to Controller with Mouse HID", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.addTarget(self, action: #selector(onButtonSetToControllerMouseHIDTapped), for: .touchUpInside)
		return button
	}
	
	@objc func onButtonSetToRawTapped() {
//		let inputMode = TAPInputMode.rawSensor(
//			sensitivity: TAPRawSensorSensitivity(
//				deviceAccelerometer: 1, 
//				imuGyro: 1, 
//				imuAccelerometer: 1
//			)
//		)
		let inputMode = TAPInputMode.rawSensor(
			sensitivity: TAPRawSensorSensitivity()
		)
		TAPKit.sharedKit.setDefaultTAPInputMode(inputMode, immediate: true)
	}
	
	@objc func onButtonSetToKeyboardTapped() {
		let inputMode = TAPInputMode.text()
		TAPKit.sharedKit.setDefaultTAPInputMode(inputMode, immediate: true)
	}
	
	@objc func onButtonSetToControllerTapped() {
		let inputMode = TAPInputMode.controller()
		TAPKit.sharedKit.setDefaultTAPInputMode(inputMode, immediate: true)
	}
	
	@objc func onButtonSetToControllerMouseHIDTapped() {
		let inputMode = TAPInputMode.controllerWithMouseHID()
		TAPKit.sharedKit.setDefaultTAPInputMode(inputMode, immediate: true)
	}
}

