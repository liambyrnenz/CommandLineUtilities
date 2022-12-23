//
//  TerminalHelper.swift
//  CommandLineUtilities
//
//  Created by Liam on 23/12/22.
//

import Foundation

/// A helper that exposes the ability to run commands inside of a terminal and retrieve the output.
public class TerminalHelper {
    
    /// Run a terminal command and return any output it produces, including error messages.
    ///
    /// - Parameter command: command string to run in the terminal
    /// - Returns: command output, if any
    @discardableResult
    public static func execute(_ command: String, wait: Bool = true) -> String {
        let process = Process()
        
        process.launchPath = "/usr/bin/env"
        process.arguments = ["bash", "-c", command]
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        process.launch()
        if wait {
            process.waitUntilExit()
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? ""
    }
    
}
