//
//  NSObject.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import Foundation

extension NSObject {
    var className: String {
        NSStringFromClass(type(of: self))
    }
}
