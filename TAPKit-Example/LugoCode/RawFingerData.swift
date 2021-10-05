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
	
	private enum SensorState {
		case waiting
		case snapshot(RawSensorData)
	}
	
	var fingerPositions: [Fingers: Point3] = [:]
	var imuPositions: [IMU: Point3] = [:]
	
	private var sensorState: SensorState = .waiting
	private var addQueue = DispatchQueue(label: "RawSensorInput", qos: .userInitiated)
	private var consumeQueue = DispatchQueue(label: "RawSensorInput", qos: .userInitiated)
	
	func update(data: RawSensorData) {
		addQueue.async { [data] in
			self.doUpdate(data)
		}
	}
	
	private func doUpdate(_ data: RawSensorData) {
		sensorState = .snapshot(data) 
		switch data.type {
			case .Device:
				Fingers.allCases.forEach {
					if let rawPoint = data.getPoint(for: $0.rawSensorID) {
						fingerPositions[$0] = rawPoint
					}
				}
			case .IMU:
				IMU.allCases.forEach {
					if let rawPoint = data.getPoint(for: $0.rawIMUID) {
						imuPositions[$0] = rawPoint
					}
				}
			case .None:
				break
		}
	}
}
