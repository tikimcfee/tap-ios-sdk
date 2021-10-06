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
	
	private let circlesView = FingerCirclesView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        TAPKit.sharedKit.addDelegate(tapDelegate)
        TAPKit.log.disable(event: .warning)
        TAPKit.log.enableAllEvents()
        TAPKit.sharedKit.start()
        // let taps = TAPKit.sharedKit.getConnectedTaps()
		
		view.addSubview(circlesView)
		NSLayoutConstraint.activate([
			circlesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			circlesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			circlesView.topAnchor.constraint(equalTo: view.topAnchor),
			circlesView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TAPKit.sharedKit.removeDelegate(tapDelegate)
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func TEST__rawMode() {
//		let inputMode = TAPInputMode.rawSensor(
//			sensitivity: TAPRawSensorSensitivity(
//				deviceAccelerometer: 0, 
//				imuGyro: 0, 
//				imuAccelerometer: 0
//			)
//		)
//		TAPKit.sharedKit.setDefaultTAPInputMode(inputMode, immediate: true)
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
}

