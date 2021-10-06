//
//  RawFingerData.swift
//  TAPKit-Example
//
//  Created by Ivan Lugo on 10/4/21.
//  Copyright © 2021 Shahar Biran. All rights reserved.
//

import Foundation
import TAPKit

extension Fingers {
	var rawSensorID: Int {
		switch self {
			case .thumb: return RawSensorData.iDEV_THUMB
			case .index: return RawSensorData.iDEV_INDEX
			case .middle: return RawSensorData.iDEV_MIDDLE
			case .ring: return RawSensorData.iDEV_RING
			case .pinky: return RawSensorData.iDEV_PINKY
		}
	}
}

enum IMU: CaseIterable {
	case gyro
	case accelerometer
	
	var rawIMUID: Int {
		switch self {
			case .gyro: 
				return RawSensorData.iIMU_GYRO
			case .accelerometer: 
				return RawSensorData.iIMU_ACCELEROMETER
		}
	}
}

class RawSensorState {
	
	private var fingerPositions: [Fingers: LList<Point3>] = [:]
	private var imuPositions: [IMU: LList<Point3>] = [:]
	private var addQueue = DispatchQueue(label: "RawSensorInput", qos: .userInitiated)
	
	func update(data: RawSensorData) {
		addQueue.async { [data] in
			self.doUpdate(data)
		}
	}
	
	func readFingers(_ reader: (Fingers, Point3) -> Void) {
		Fingers.allCases.forEach { finger in
			fingerPositions[finger]?.forEach { pointPosition in 
				reader(finger, pointPosition)
			}
		}
	}
	
	func readIMU(_ reader: (IMU, Point3) -> Void) {
		IMU.allCases.forEach { imu in
			imuPositions[imu]?.forEach { pointPosition in 
				reader(imu, pointPosition)
			}
		}
	}
	
	func makeFingerIterators(_ reader: (Fingers, LList<Point3>.Iterator) -> Void) {
		Fingers.allCases.forEach { finger in
			let iterator = (fingerPositions[finger] ?? LList()).makeIterator()
			reader(finger, iterator)
		}
	}
	
	func makeIMUIterators(_ reader: (IMU, LList<Point3>.Iterator) -> Void) {
		IMU.allCases.forEach { imu in
			let iterator = (imuPositions[imu] ?? LList()).makeIterator()
			reader(imu, iterator)
		}
	}
	
	private func doUpdate(_ data: RawSensorData) { 
		switch data.type {
			case .Device:
				Fingers.allCases.forEach {
					if let rawPoint = data.getPoint(for: $0.rawSensorID) {
						let list = fingerPositions[$0] ?? LList()
						list.append(rawPoint)
						fingerPositions[$0] = list
					}
				}
			case .IMU:
				IMU.allCases.forEach {
					if let rawPoint = data.getPoint(for: $0.rawIMUID) {
						let list = imuPositions[$0] ?? LList()
						list.append(rawPoint)
						imuPositions[$0] = list
					}
				}
			case .None:
				break
		}
	}
}
