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
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                
                let schools = try await nycSchoolService?.getNYCSchools(limit: limit, offset: currentOffset, sortKey: sortkey, sortOrder: sortOrder)
                
                DispatchQueue.main.async {
                    if let schools,
                       !schools.isEmpty {
                        self.nycSchools += schools
                        self.currentOffset += self.limit
                    } else {
                        self.allDataLoaded = true
                    }
                    self.getNYCSchoolsCompletionHandler?(nil)
                    
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.getNYCSchoolsCompletionHandler?(error)
                }
            }
        }
    }
    
    func getAllNYCSchools() async {
        do {
            DispatchQueue.main.async {
                self.isLoading = true
            }

            if let schools = try await nycSchoolService?.getAllNYCSchools() {
                DispatchQueue.main.async {
                    self.filteredNycSchools = []
                    self.nycSchools = schools
                    self.getNYCSchoolsCompletionHandler?(nil)
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.getNYCSchoolsCompletionHandler?(error)
            }
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
