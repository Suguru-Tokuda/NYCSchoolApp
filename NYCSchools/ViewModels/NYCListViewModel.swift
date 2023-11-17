//
//  NYCListViewModel.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

protocol NYCSchoolListSearchDelegate: AnyObject {
    func searchSchoolsCompleted()
}

class NYCListViewModel {
    private var limit: Int = 20
    private var currentOffset: Int = 0
    private var allDataLoaded: Bool = false
    var sortkey: NYCSchoolSortKey = .collegeCareerRate
    var sortOrder: SortOrder = .dsc
    var nycSchools: [NYCSchool] = []
    var filteredNycSchools: [NYCSchool] = []
    private var nycSchoolService: NYCSchoolService?
    var getNYCSchoolsCompletionHandler: ((Error?) -> ())?
    weak var delegate: NYCSchoolListSearchDelegate?
    
    init(nycSchoolService: NYCSchoolService = NYCSchoolService()) {
        self.nycSchoolService = nycSchoolService
        self.currentOffset = self.limit
    }
    
    func getNYCSchools() async {
        if !allDataLoaded {
            do {
                let schools = try await nycSchoolService?.getNYCSchools(limit: limit, offset: currentOffset, sortKey: sortkey, sortOrder: sortOrder)
                
                if let schools,
                   !schools.isEmpty {
                    self.nycSchools += schools
                    currentOffset += limit
                } else {
                    allDataLoaded = true
                }
                self.getNYCSchoolsCompletionHandler?(nil)
            } catch {
                self.getNYCSchoolsCompletionHandler?(error)
            }
        }
    }
    
    func getAllNYCSchools() async {
        do {
            if let schools = try await nycSchoolService?.getAllNYCSchools() {
                self.filteredNycSchools = []
                self.nycSchools = schools
                self.getNYCSchoolsCompletionHandler?(nil)
            }
        } catch {
            self.getNYCSchoolsCompletionHandler?(error)
        }
    }
    
    func resetAndGetSchools(sortKey: NYCSchoolSortKey, sortOrder: SortOrder) async {
        allDataLoaded = false
        currentOffset = 0
        nycSchools = []
        self.sortkey = sortKey
        self.sortOrder = sortOrder
        await getNYCSchools()
    }
    
    /**
        Search high schools names by text
     */
    func searchNYCSchools(searchText: String) {
        self.filteredNycSchools = self.nycSchools.filter { $0.schoolName.lowercased().contains(searchText.lowercased()) }
        self.delegate?.searchSchoolsCompleted()
    }
}
