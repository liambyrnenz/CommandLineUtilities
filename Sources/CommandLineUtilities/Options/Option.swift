//
//  Option.swift
//  CommandLineUtilities
//
//  Created by Liam on 23/12/22.
//

public typealias OptionVariations = Set<String>

/// A property wrapper that is used on option properties (i.e. properties that represent available
/// options that can be provided to the application.) It essentially bundles value storage with
/// metadata for the option, like the variations of strings used to invoke it.
@propertyWrapper
public struct Option<Value> {
    
    /// The set of strings that represent the different variations this option responds to.
    private(set) public var variations: OptionVariations
    
    /// The internal storage for the option's value.
    private var value: Value
    
    /// The public-facing accessor for the option's value.
    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            self.value = newValue
        }
    }
    
    /// A read-only copy of this option's variations set.
    public var projectedValue: OptionVariations { variations }
    
    public init(wrappedValue: Value, _ variations: String...) {
        self.variations = OptionVariations(variations)
        self.value = wrappedValue
    }
    
}

// Extension to provide convenient nil initializer.
extension Option where Value: ExpressibleByNilLiteral {
    
    public init(_ variations: String...) {
        self.variations = OptionVariations(variations)
        self.value = nil
    }
    
}
