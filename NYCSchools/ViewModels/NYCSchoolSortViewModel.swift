//
//  NYCSchoolSortViewModel.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/16/23.
//

import Foundation

class NYCSchoolSortViewModel {
    private var sortOrder: SortOrder = .asc
    private var sortKey: NYCSchoolSortKey = .schoolName
    
    func setValues(sortKey: NYCSchoolSortKey, sortOrder: SortOrder) {
        self.sortOrder = sortOrder
        self.sortKey = sortKey
    }
    
    func setSortOrder(sortOrder: SortOrder) {
        self.sortOrder = sortOrder
    }
    
    func setSortKey(sortKey: NYCSchoolSortKey) {
        self.sortKey = sortKey
    }
    
    func getSelectionValues() -> (NYCSchoolSortKey, SortOrder) {
        return (sortKey, sortOrder)
    }
}
