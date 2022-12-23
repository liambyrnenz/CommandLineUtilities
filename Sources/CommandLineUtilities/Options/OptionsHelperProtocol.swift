//
//  OptionsHelperProtocol.swift
//  CommandLineUtilities
//
//  Created by Liam on 23/12/22.
//

public enum OptionsError: Error {
    case invalidArguments(hints: [String]?)
    
    public var localizedDescription: String {
        switch self {
        case .invalidArguments:
            return "invalid arguments were passed in, please check and try again"
        }
    }
}

/// A protocol that provides standard required methods and handy utilities for options helper classes.
/// 
/// Generally, a command line application that uses this library will have some way to handle flags (or
/// "options"). This protocol provides a basis for applications that wish to use a singleton options helper
/// that evaluates arguments using predefined sets.
public protocol OptionsHelperProtocol {
    
    /// Evaluate the arguments passed to the application for any options that need to be kept track of.
    ///
    /// Note that this method isn't really in the protocol as it needs to be exposed to callers, but more to
    /// host the method documentation and guarantee that this evaluation entry method is provided.
    ///
    /// - Parameter arguments: list of arguments passed to the application, excluding the execution command
    /// - Returns: original list of arguments filtered of any options and their parameters
    /// - Throws: OptionsError if options are malformed
    func evaluate(_ arguments: [String]) throws -> [String]
    
}

public extension OptionsHelperProtocol {
    
    /// Extract and return the variation from the given option variations that was provided in the given arguments, if
    /// this option was provided at all.
    ///
    /// - Parameters:
    ///   - arguments: arguments list from evaluation
    ///   - optionVariations: the set of variations for the option (which defines the option we are working with)
    /// - Throws: `OptionsError` if multiple variations of the same option were provided in the arguments
    /// - Returns: the provided variation of the option, if it exists in the arguments, or nil otherwise
    func providedOption(in arguments: [String], from optionVariations: OptionVariations) throws -> String? {
        let intersection = Set(arguments).intersection(optionVariations)
        
        // an empty intersection means no variations of the option are present in the arguments
        if intersection.isEmpty {
            return nil
        }
        
        // more than 1 element in the intersection means multiple variations were provided, which is invalid
        // e.g. `-a -a` or `-a --action` (assuming -a and --action are variations of the same option)
        if intersection.count > 1 {
            throw OptionsError.invalidArguments(hints: ["too many variations of the option \(optionVariations) were provided"])
        }
        
        return intersection.first
    }
    
    /// Remove **all** option flags from the given arguments.
    func removeAllOptions(from arguments: inout [String]) {
        arguments = arguments.filter({ $0.starts(with: "-") == false })
    }
    
    /// Remove the provided list of strings from the arguments list. These strings are generally option variations
    /// and any associated arguments that are no longer needed.
    func remove(_ strings: [String], fromArguments arguments: inout [String]) {
        arguments.removeAll(where: strings.contains)
    }
    
}
