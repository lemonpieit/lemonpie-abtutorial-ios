//
//  Logger.swift
//
//  Created by Francesco Leoni on 10/10/2020.
//  Copyright © 2020 All rights reserved.
//

import Foundation
import os

/// Defines the basic function of a `Logger`.
protocol Logging {
    
  /// Prints to the `Debug area` and to the `Console` a custom message.
  ///
  /// - Parameters:
  ///   - type: The log level.
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func print(type: Logger.Level, _ message: Any, line: UInt, funcName: String, filePath: String)
}

extension Logging {
    
  /// Prints an `Info` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func info(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .info, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints a `Debug` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func debug(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .debug, message, line: line, funcName: funcName, filePath: filePath)
  }
      
  /// Prints a `Warning` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func warning(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .warning, message, line: line, funcName: funcName, filePath: filePath)
  }

  /// Prints an `Error` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func error(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .error, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints a `Fatal error` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func fatal(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: StaticString = #file) {
    print(type: .fatal, message, line: line, funcName: funcName, filePath: "\(filePath)")
    Swift.fatalError("\(message)", file: filePath, line: line)
  }
}

class Logger: Logging {
  
  /// Defines whether the internal logs are enabled.
  /// - Note: Set to false when published.
  static var isEnabled: Bool = true
  
  enum Level: String {
    case info = "INFO"
    case debug = "DEBUG"
    case warning = "WARNING"
    case error = "ERROR"
    case fatal = "FATAL"
  }
    
  // MARK: - Generic
  
  /// Prints an `Warning` message to the `Debug area` and to the `Console`.
  /// - Note: Use this function to print user-related errors.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  static func warning(_ warning: ABTWarning) {
    let osMessage = "WARNING \(warning.warningCode): \(warning.warningDescription)"
    os_log("%{public}@", log: .abtutorial, type: OSLogType.from(loggerLevel: .error), osMessage as NSString)
  }

  /// Prints an `Error` message to the `Debug area` and to the `Console`.
  /// - Note: Use this function to print user-related errors.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  static func error(_ error: ABTError) {
    let osMessage = "ERROR \(error.errorCode): \(error.errorDescription)"
    os_log("%{public}@", log: .abtutorial, type: .from(loggerLevel: .error), osMessage as NSString)
  }

  static func print(type: Level, _ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    if isEnabled {
      let osMessage = "\(type.rawValue) [\(sourceFileName(filePath: filePath)).\(funcName)] line \(line) -> \(message)"
      os_log("%{private}@", log: .abtutorial, type: .from(loggerLevel: type), osMessage as NSString)
    }
  }
}

extension Logger {
  private static func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    let filename = components.isEmpty ? "" : (components.last ?? "")
    let filenameComponents = filename.components(separatedBy: ".")
    return filenameComponents.first ?? ""
  }
}

extension OSLog {
  private static var subsystem = Bundle.main.bundleIdentifier!
  
  static let abtutorial = OSLog(subsystem: subsystem, category: "ABtutorial")  
}

extension OSLogType {
  static func from(loggerLevel: Logger.Level) -> Self {
    switch loggerLevel {
    case .info:
      return .info
    case .debug, .warning:
      return .default
    case .error:
      return .error
    case .fatal:
      return .fault
    }
  }
}
