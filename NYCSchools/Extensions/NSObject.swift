//
//  NSObject.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import Foundation

extension NSObject {
    var className: String {
        get {
            return NSStringFromClass(type(of: self))
        }
    }
}
