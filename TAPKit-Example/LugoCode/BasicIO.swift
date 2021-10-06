//
//  IO.swift
//  IOTAPS
//
//  Created by Ivan Lugo on 10/5/21.
//  Copyright © 2021 Shahar Biran. All rights reserved.
//

import Foundation

// MARK: - File Operations
public struct AppFiles {
	
	private static let fileManager = FileManager.default
	
	private static var documentsDirectory: URL {
		let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	public static func directory(named directoryName: String) -> URL {
		let directory = documentsDirectory.appendingPathComponent(directoryName, isDirectory: true)
		if !fileManager.fileExists(atPath: directory.path) {
			try! fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
		}
		return directory
	}
	
	public static func file(named fileName: String, in directory: URL) -> URL {
		let fileUrl = directory.appendingPathComponent(fileName)
		if !fileManager.fileExists(atPath: fileUrl.path) {
			fileManager.createFile(atPath: fileUrl.path, contents: Data(), attributes: nil)
		}
		return fileUrl
	}
}

extension AppFiles {
	public static var dataDirectory: URL {
		directory(named: "xyz-tapstrap-testing-zyx")
	}
	
	public static var fingerDataFile: URL {
		file(named: "fingerfiles.raw", in: dataDirectory)
	}
	
	public static var imuDataFile: URL {
		file(named: "imufiles.raw", in: dataDirectory)
	}
}

public struct DirectAppendFileStore {
	var flatFile: URL
	
	func appendText(_ text: String, encoded encoding: String.Encoding = .utf8) {
		if let data = text.data(using: encoding) {
			do {
				try appendToFile(data)
			} catch {
#if DEBUG
				fatalError("Text appending failed: \(error)")
#endif
			}
		}
	}
	
	func appendToFile(_ data: Data) throws {
		let handle = try FileHandle(forUpdating: flatFile)
		handle.seekToEndOfFile()
		handle.write(data)
		try handle.close()
	}
}

extension URL {
	var hasData: Bool {
		let attributes = try? FileManager.default.attributesOfItem(atPath: path) as NSDictionary
		let size = attributes?.fileSize() ?? 0
		return size > 0
	}
}
