//
//  Logger.swift
//  CommandLineUtilities
//
//  Created by Liam on 23/12/22.
//

public protocol Logger {
    
    /// Write a message to the logger.
    ///
    /// - Parameters:
    ///   - message: message to write to the logger's output
    func write(message: String)
    
    /// Write an object or list of objects to the logger.
    ///
    /// - Parameter object: variadic object parameter
    func write(_ object: Any...)
    
}
