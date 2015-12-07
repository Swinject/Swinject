//
//  JsonPropertyLoader.swift
//  Swinject
//
//  Created by mike.owens on 12/6/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation


/// The JsonPropertyLoader will load properties from JSON resources
final public class JsonPropertyLoader {
    
    /// the bundle where the resource exists (defualts to mainBundle)
    private let bundle: NSBundle
    
    /// the name of the JSON resource. For example, if your resource is "properties.json" then this value will be set to "properties"
    private let name: String
    
    ///
    /// Will create a JSON property loader
    ///
    /// - parameter bundle: the bundle where the resource exists (defaults to mainBundle)
    /// - parameter name:   the name of the JSON resource. For example, if your resource is "properties.json" 
    ///                     then this value will be set to "properties"
    ///
    public init(bundle: NSBundle? = .mainBundle(), name: String) {
        self.bundle = bundle!
        self.name = name
    }
    
    /// Will strip the provide string of comments. This allows JSON property files to contain comments as it
    /// is valuable to provide more context to a property then just its key-value and comments are not valid JSON
    /// so this will process the JSON string before we attempt to parse the JSON into objects
    ///
    /// Implementation influence by Typhoon:
    /// https://github.com/appsquickly/Typhoon/blob/master/Source/Configuration/ConfigPostProcessor/TyphoonConfiguration/TyphoonJsonStyleConfiguration.m#L30
    ///
    /// - Parameter str: the string to strip of comments
    ///
    /// - Returns: the json string stripper of comments
    private func stringWithoutComments(str: String) -> String {
        let pattern = "(([\"'])(?:\\\\\\2|.)*?\\2)|(\\/\\/[^\\n\\r]*(?:[\\n\\r]+|$)|(\\/\\*(?:(?!\\*\\/).|[\\n\\r])*\\*\\/))"
        let expression = try? NSRegularExpression(pattern: pattern, options: .AnchorsMatchLines)
        
        let matches = expression!.matchesInString(str, options: NSMatchingOptions(rawValue: 0),
            range: NSMakeRange(0, str.characters.count))
        
        guard !matches.isEmpty else {
            return str
        }
        
        let ret = NSMutableString(string: str)
        
        for match in matches.reverse() {
            let character = String(str[str.startIndex.advancedBy(match.range.location)])
            if character != "\'" && character != "\"" {
                ret.replaceCharactersInRange(match.range, withString: "")
            }
        }
        return ret as String
    }
}

// MARK: - PropertyLoadable
extension JsonPropertyLoader: PropertyLoadable {
    public func load() -> [String : AnyObject]? {
        if let contents: String = loadStringFromBundle(bundle, withName: name, ofType: "json") {
            let jsonWithoutComments = stringWithoutComments(contents)
            let data = jsonWithoutComments.dataUsingEncoding(NSUTF8StringEncoding)
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? [String:AnyObject] {
                    return json
                } else {
                    fatalError("Unable to cast JSON properties from bundle: \(bundle) for name: \(name)")
                }
            } catch {
                fatalError("Unable to read JSON properties from bundle: \(bundle) for name: \(name)")
            }
        }
        return nil
    }
}
