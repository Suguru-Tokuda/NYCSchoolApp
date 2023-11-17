//
//  SortOrder.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/16/23.
//

import Foundation

enum SortOrder: String, CaseIterable {
    case asc = "Ascending", dsc = "Descending"
    
    func getSortOrderStr() -> String {
        switch self {
        case .asc:
            return "ASC"
        case .dsc:
            return "DESC"
        }
    }
}
