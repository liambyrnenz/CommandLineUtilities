//
//  FileHelper.swift
//  CommandLineUtilities
//
//  Created by Liam on 23/12/22.
//

import Foundation

/// An error enumeration for `FileHelper` that provides errors for reading and writing failures.
public enum FileError: Error {
    case readingFailed(rawLog: String?)
    case writingFailed(rawLog: String?)
    
    var localizedDescription: String {
        switch self {
        case .readingFailed:
            return "failed to read contents from file"
        case .writingFailed:
            return "failed to write contents to file"
        }
    }
}

/// A helper that exposes common functions for working with files, as well as offering some file-oriented terminal interface methods.
public class FileHelper {
    
    /// Read the file at the given path into a String and return it.
    ///
    /// - Parameter path: filepath to file
    /// - Returns: file contents in String form
    /// - Throws: FileError if file operations fail
    public static func read(fileAt path: String) throws -> String {
        let location = path.replacingOccurrences(of: "~", with: FileManager.default.homeDirectoryForCurrentUser.path)
        do {
            let fileContent = try String(contentsOfFile: location)
            return fileContent
        } catch {
            throw FileError.readingFailed(rawLog: error.localizedDescription)
        }
    }
    
    /// Write the given String contents into a file in the specified or current directory named with the given name.
    ///
    /// - Parameters:
    ///   - contents: file contents in String form
    ///   - path: name of file to write contents into (if `inCurrentDirectory` is false, this should be an absolute path)
    ///   - inCurrentDirectory: specifies whether to write the file into the current terminal directory
    /// - Throws: FileError if file operations fail
    public static func write(fileContents contents: String, into path: String, inCurrentDirectory: Bool = true) throws {
        let location: URL
        if inCurrentDirectory {
            location = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(path)
        } else {
            location = URL(fileURLWithPath: path)
        }
        
        do {
            try contents.write(to: location, atomically: false, encoding: .utf8)
        } catch {
            throw FileError.writingFailed(rawLog: error.localizedDescription)
        }
    }

}
