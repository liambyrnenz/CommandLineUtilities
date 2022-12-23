//
//  CategoryLogger.swift
//  CommandLineUtilities
//
//  Created by Liam on 23/12/22.
//

/// A fixed enumeration of logger categories that can be used with `CategoryLogger`.
public enum LoggerCategory: String {
    case debug = "DEBUG"        // debug messages
    case info = "INFO"          // general information about program status
    case error = "ERROR"        // error messages
    case complete = "COMPLETE"  // program completed successfully
    case option = "OPTION"      // shows information about options enabled
    case output = "OUTPUT"      // marks output from other processes
    case hint = "HINT"          // hints for resolving errors
    case none
}

/// A primitive logger that prints formatted messages (optionally with categories) to the console using Swift's standard output.
///
/// This class and its methods are marked as open to allow for free extension and modification.
open class CategoryLogger: Logger {
    
    public init() {}
    
    // this simply writes a no-category message
    open func write(message: String) {
        write(message: message, category: .none)
    }
    
    open func write(_ object: Any...) {
        print(object)
    }
    
    /// Write a message to the logger, optionally with an associated category.
    ///
    /// - Parameters:
    ///   - message: message to write to the logger's output
    ///   - category: message category (prefixes the message with a category as seen in LoggerCategory)
    ///   - shouldShowDebug: specifies whether to show messages marked with the `.debug` category (defaults to false)
    open func write(message: String, category: LoggerCategory = .none, shouldShowDebug: Bool = false) {
        // show debug messages only if specified to
        if category == .debug, shouldShowDebug == false {
            return
        }
        
        let prefix = category == .none ? "" : "\(category.rawValue): "
        print(prefix + message)
    }
    
}
