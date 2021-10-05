//
//  OriginalNotes.swift
//  TAPKit-Example
//
//  Created by Ivan Lugo on 10/4/21.
//  Copyright © 2021 Shahar Biran. All rights reserved.
//

import Foundation

/**
 
 // Any class that wish to get taps related callbacks, must add itself as a delegate:
 TAPKit.sharedKit.addDelegate(self)
 
 // You can enable/disable logs for specific events, or all events
 // TAPKitLogEvent.error, TAPKitLogEvent.fatal, TAPKitLogEvent.info, TAPKitLogEvent.warning
 // For example, to enable only errors logs:
 // TAPKit.log.enable(event: .error)
 TAPKit.log.disable(event: .warning)
 TAPKit.log.enableAllEvents()
 
 // start should be called typically in the main screen, after the delegate was being set earlier.
 TAPKit.sharedKit.start()
 
 // At any point of your app, you may get the connected taps:
 // result is a dictionary format of [identifier:name]
 // let taps = TAPKit.sharedKit.getConnectedTaps()
 
 
 // Tap Input mode:
 // ---------------
 // TAPInputMode.controller()
 //      allows receiving the "tapped" and "moused" funcs callback in TAPKitDelegate with the fingers combination without any post-processing.
 //
 // TAPInputMode.text()
 //      "tapped" and "moused" funcs in TAPKitDelegate will not be called, the TAP device will be acted as a plain bluetooth keyboard.
 //
 // TAPInputMode.controllerWithMouseHID() -
 //      Same as controller mode but allows the user to use the mouse also as a regular mouse input.
 //      Starting iOS 13, Apple added Assitive Touch feature. (Can be toggled within accessibility settings on iPhone).
 //      This adds a cursor to the screen that can be navigated using TAP device.
 //
 // TAPInputMode.rawSensor(sensitivity: TAPRawSensorSensitivity(deviceAccelerometer: Int, imuGyro: Int, imuAccelerometer: Int))
 //      Sends sensor (Gyro and Accelerometers) data . callback function: rawSensorDataReceived. read the readme.md for more information about this mode.
 //
 // If you wish for a TAP device to enter text as part of your app, you'll need to set the mode to TAPInputMode.text(), and when you want to receive tap combination data,
 // you'll need to set the mode to TAPInputMode.controller()
 // Setting text mode:
 // TAPKit.sharedKit.setTAPInputMode(TAPInputMode.text(), forIdentifiers: [tapidentifiers])
 // tapidentifiers : array of identifiers of tap devices to set the mode to text. if nil - all taps devices connected to the iOS device will be set to text.
 // Same for settings the mode to controller:
 // TAPKit.sharedKit.setTAPInputMode(TAPInputMode.controller(), forIdentifiers: [tapIdentifiers])
 //      When [tapIdentifiers] is null or missing - the mode will be applied to ALL connected TAPs.
 //
 // Setting the default TAPInputMode for new TAPs that will be connected. (can be applied to current connected TAPs):
 // TAPKit.sharedKit.setDefaultTAPInputMode(TAPInputMode..., immediate: true/false)
 //      "immediate" - When true, this mode will be applied to all currently connected TAPs.
 
 
 // Air Gestures
 // ------------
 // TAP v2.0 devices adds Air Gestures features.
 // These Air Gestures will be triggered in:
 //      func tapAirGestured(identifier: String, gesture: TAPAirGesture)
 // Please refer to the enum TAPAirGesture to see the available gestures.
 // Works in "controller" and "controllerWithMouseHID" modes.
 // Another related callback event is:
 //      func tapChangedAirGesturesState(identifier: String, isInAirGesturesState: Bool)
 //          This event will be triggered when the TAP entering or leaving Air Gesture State.
 
 // Send Haptic/Vibration to TAP devices.
 // To make the TAP vibrate, to your specified array of durations, call:
 // TAPKit.sharedKit.vibrate(durations: [hapticDuration, pauseDuration, hapticDuration, pauseDuration, ...], forIdentifiers: [tapIdentifiers])
 //      durations: An array of durations in the format of haptic, pause, haptic, pause ... You can specify up to 18 elements in this array. The rest will be ignored.
 //                 Each array element is defined in milliseconds.
 //      When [tapIdentifiers] is null or missing - the mode will be applied to ALL connected TAPs.
 //      Example:
 //          TAPKit.sharedKit.vibrate(durations: [500,100,500])
 //          Will send two 500 milliseconds haptics with a 100 milliseconds pause in the middle.
 
 */
