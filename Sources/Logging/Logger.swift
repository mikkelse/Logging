//
//  Logger.swift
//  Logging
//
//  Created by Mikkel Sindberg Eriksen on 27/05/2022.
//

import Foundation

/// A protocol defining an interface for something that can log.
public protocol LoggerProtocol {

    /// Log a message with the given log level
    ///
    /// - parameter level: The log level of the event.
    /// - parameter className: The name of the class that logged the event.
    /// - parameter message: The message of the log event.
    /// - parameter function: The function that logged the event.
    /// - parameter line: The line number of the code that logged the event.
    func log(level: LogLevel, className: String, message: @autoclosure () -> Any, function: String, line: Int)
}

/// A class providing a singleton interface for logging.
public final class Logger: LoggerProtocol {

    private var activeLogger: LoggerProtocol?

    /// The singleton instance of the logger.
    public static var sharedInstance = Logger()
    private init() {}

    /// Setup the logger with the given logger.
    ///
    /// - parameter logger: The logger that the logger should log to.
    public func setupLogger(logger: LoggerProtocol) {
        guard activeLogger == nil else { fatalError("Changing logger is not allowed to maintain consistency") }
        activeLogger = logger
    }

    public func log(level: LogLevel, className: String, message: @autoclosure () -> Any, function: String, line: Int) {
        activeLogger?.log(level: level, className: className, message: message(), function: function, line: line)
    }
}
