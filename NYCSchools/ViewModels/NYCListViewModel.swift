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
    var isLoading: Bool = false
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
                self.isLoading = true
                
                let schools = try await nycSchoolService?.getNYCSchools(limit: limit, offset: currentOffset, sortKey: sortkey, sortOrder: sortOrder)
                if let schools,
                   !schools.isEmpty {
                    nycSchools += schools
                    currentOffset += self.limit
                } else {
                    allDataLoaded = true
                }

                getNYCSchoolsCompletionHandler?(nil)
                isLoading = false
            } catch {
                isLoading = false
                getNYCSchoolsCompletionHandler?(error)
            }
        }
    }
    
    func getAllNYCSchools() async {
        do {
            isLoading = true

            if let schools = try await nycSchoolService?.getAllNYCSchools() {
                filteredNycSchools = []
                nycSchools = schools
                getNYCSchoolsCompletionHandler?(nil)
                isLoading = false
            } else {
                isLoading = false
            }
        } catch {
            isLoading = false
            getNYCSchoolsCompletionHandler?(error)
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
        // filter by school name or address
        self.filteredNycSchools = self.nycSchools.filter { $0.schoolName.lowercased().contains(searchText.lowercased()) || $0.address.lowercased().contains(searchText.lowercased()) }
        self.delegate?.searchSchoolsCompleted()
    }
}
