//
//  Loggable.swift
//  Logging
//
//  Created by Mikkel Sindberg Eriksen on 30/11/2017.
//

import Foundation

/// An enum defining different levels of logging.
public enum LogLevel: Int, CaseIterable {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

/// A protocol defining an interface for something that is loggable.
public protocol Loggable {

    /// Log the given event with the given log level.
    ///
    /// - parameter level: The log level of the event.
    /// - parameter message: The message of the log event.
    /// - parameter function: The function that logged the event.
    /// - parameter line: The line number of the code that logged the event.
    func log(level: LogLevel, message: @autoclosure () -> Any, function: String, line: Int)

    /// Static version of log, for class level logging, when instance member is not available. during init for example.
    static func log(level: LogLevel, message: @autoclosure () -> Any, function: String, line: Int)
}

extension Loggable {

    /// A default implementation of log providing function and line number as default arguments.
    public func log(level: LogLevel, message: @autoclosure () -> Any, function: String = #function, line: Int = #line) {
        Self.log(level: level, className: String(describing: type(of: self)), message: message(), function: function, line: line)
    }

    public static func log(level: LogLevel, message: @autoclosure () -> Any, function: String = #function, line: Int = #line) {
        log(level: level, className: String(describing: self), message: message(), function: function, line: line)
    }

    private static func log(level: LogLevel, className: String, message: @autoclosure () -> Any, function: String, line: Int) {
        Logger.sharedInstance.log(level: level, className: className, message: message(), function: function, line: line)
    }
}
