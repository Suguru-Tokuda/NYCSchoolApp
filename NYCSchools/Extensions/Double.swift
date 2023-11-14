//
//  Double.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import Foundation

extension Double {
    func toPercentageStr(decimalPlaces: Int) -> String {
        return "\(String(format: "%.\(decimalPlaces)f", self * 100.0))%"
    }
}
