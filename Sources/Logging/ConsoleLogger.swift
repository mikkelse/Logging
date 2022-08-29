//
//  ConsoleLogger.swift
//  Logging
//
//  Created by Mikkel Sindberg Eriksen on 27/05/2022.
//

import Foundation

/// A simple logger for logging to the console.
public final class ConsoleLogger: LoggerProtocol {
    
    private let levels: [LogLevel]

    /// Initialize the logger with the given log levels.
    /// - parameter levels: The log levels to log to the conolse. Defaults to all.
    public init(levels: [LogLevel] = LogLevel.allCases) {
        self.levels = levels
    }

    public func log(level: LogLevel, className: String, message: @autoclosure () -> Any, function: String, line: Int) {
        guard levels.contains(level) else { return }
        print("\(prefix(for: level)) - \(className).\(function) (\(line)): \(message())")
    }

    private func prefix(for level: LogLevel) -> String {

        let symbol: String

        switch level {
        case .verbose: symbol = "🔵"
        case .debug: symbol = "🟢"
        case .info: symbol = "🟡"
        case .warning: symbol = "🟠"
        case .error: symbol = "🔴"
        }

        return "\(symbol) \(String(describing: level).capitalized)"
    }
}
