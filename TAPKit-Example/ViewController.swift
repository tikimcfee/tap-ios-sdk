//
//  ViewController.swift
//  TAPKit-Example
//
//  Created by Shahar Biran on 08/04/2018.
//  Copyright © 2018 Shahar Biran. All rights reserved.
//

import UIKit
import TAPKit

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
	
	func TEST__flashRandomFingers() {
		circlesView.displayFingers([Fingers.allCases.randomElement()!, Fingers.allCases.randomElement()!])
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: TEST__flashRandomFingers)
	}
	
	private func makeTestDelegate() -> TAPKitDelegate {
		let delegate = StartingTapDelegate()
		delegate.tapUpdates = { [weak circlesView] fingers in
			circlesView?.displayFingers(fingers)
		}
		return delegate	
	}
}

typealias TapUpdates = ([Fingers]) -> Void

class StartingTapDelegate: TAPKitDelegate {
	
	var tapUpdates: TapUpdates?
	
	func centralBluetoothState(poweredOn: Bool) {
		print("Bluetooth state changed: poweredOn=\(poweredOn)")
	}
	
	func tapped(identifier: String, combination: UInt8) {
		// Called when a user tap, only when the TAP device is in controller mode.
		print("TAP \(identifier) tapped combination: \(combination)")        
		let lugoFingers = Fingers.fromIntCombination(combination)
		print("+++ lugo says: \(lugoFingers)")
		tapUpdates?(lugoFingers)
	}
	
	func tapDisconnected(withIdentifier identifier: String) {
		print("TAP \(identifier) disconnected.")
	}
	
	func tapConnected(withIdentifier identifier: String, name: String) {
		print("TAP \(identifier), \(name) connected!")
	}
	
	func tapFailedToConnect(withIdentifier identifier: String, name: String) {
		print("TAP \(identifier), \(name) failed to connect!")
	}
	
	func moused(identifier: String, velocityX: Int16, velocityY: Int16, isMouse: Bool) {
		// Added isMouse parameter:
		// A boolean that determines if the TAP is really using the mouse (true) or is it a dummy mouse movement (false)
		
		// Getting an event for when the Tap is using the mouse, called only when the Tap is in controller mode.
		// Since iOS doesn't support mouse - You can implement it in your app using the parameters of this function.
		// velocityX : get the amount of movement for X-axis.
		// velocityY : get the amount of movement for Y-axis.
	}
	
	func rawSensorDataReceived(identifier: String, data: RawSensorData) {
		if (data.type == .Device) {
			// Fingers accelerometer.
			// Each point in array represents the accelerometer value of a finger (thumb, index, middle, ring, pinky).
			if let thumb = data.getPoint(for: RawSensorData.iDEV_THUMB) {
				print("Thumb accelerometer value: (\(thumb.x),\(thumb.y),\(thumb.z))")
			}
			// Etc... use indexes: RawSensorData.iDEV_THUMB, RawSensorData.iDEV_INDEX, RawSensorData.iDEV_MIDDLE, RawSensorData.iDEV_RING, RawSensorData.iDEV_PINKY
		} else if (data.type == .IMU) {
			// Refers to an additional accelerometer on the Thumb sensor and a Gyro (placed on the thumb unit as well).
			if let gyro = data.getPoint(for: RawSensorData.iIMU_GYRO) {
				print("IMU Gyro value: (\(gyro.x),\(gyro.y),\(gyro.z)")
			}
			// Etc... use indexes: RawSensorData.iIMU_GYRO, RawSensorData.iIMU_ACCELEROMETER
		}
		// -------------------------------------------------
		// -- Please refer readme.md for more information --
		// -------------------------------------------------
	}
	
	func tapAirGestured(identifier: String, gesture: TAPAirGesture) {
		switch (gesture) {
			case .OneFingerDown : print("Air Gestured: One Finger Down")
			case .OneFingerLeft : print("Air Gestured: One Finger Left")
			case .OneFingerUp : print("Air Gestured: One Finger Up")
			case .OnefingerRight : print("Air Gestured: One Finger Right")
			case .TwoFingersDown : print("Air Gestured: Two Fingers Down")
			case .TwoFingersLeft : print("Air Gestured: Two Fingers Left")
			case .TwoFingersUp : print("Air Gestured: Two Fingers Up")
			case .TwoFingersRight : print("Air Gestured: Two Fingers Right")
			case .IndexToThumbTouch : print("Air Gestured: Index finger tapping the Thumb")
			case .MiddleToThumbTouch : print("Air Gestured: Middle finger tapping the Thumb")
		}
	}
	
	func tapChangedAirGesturesState(identifier: String, isInAirGesturesState: Bool) {
		print("Tap is in Air Gesture State: \(isInAirGesturesState)")
	}
}
