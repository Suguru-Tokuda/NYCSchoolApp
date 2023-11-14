//
//  NYCListViewModel.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

protocol NYCHighschoolListSearchDelegate {
    func searchHighschoolsCompleted()
}

class NYCListViewModel {
    private var limit: Int = 20
    private var currentOffset: Int = 0
    private var allDataLoaded: Bool = false
    var orderKey: String = "graduation_rate"
    var nycHighSchools: [NYCHighSchool] = []
    var filteredNycHighSchools: [NYCHighSchool] = []
    private var nycSchoolService: NYCHighSchoolService?
    var getNYCHighSchoolsCompletionHandler: ((Error?) -> ())?
    var delegate: NYCHighschoolListSearchDelegate?
    
    init(nycSchoolService: NYCHighSchoolService = NYCHighSchoolService()) {
        self.nycSchoolService = nycSchoolService
        self.currentOffset = self.limit
    }
    
    func getNYCHighSchools() async {
        if !allDataLoaded {
            do {
                let schools = try await nycSchoolService?.getNYCHighSchools(limit: limit, offset: currentOffset, order: orderKey)
                
                if let schools,
                   !schools.isEmpty {
                    self.nycHighSchools += schools
                    currentOffset += limit
                } else {
                    allDataLoaded = true
                }
                self.getNYCHighSchoolsCompletionHandler?(nil)
            } catch {
                self.getNYCHighSchoolsCompletionHandler?(error)
            }
        }
    }
    
    func getAllNYCHighSchools() async {
        do {
            self.getNYCHighSchoolsCompletionHandler?(nil)
            if let schools = try await nycSchoolService?.getAllNYCHighSchools() {
                self.filteredNycHighSchools = []
                self.nycHighSchools = schools
                self.getNYCHighSchoolsCompletionHandler?(nil)
            }
        } catch {
            self.getNYCHighSchoolsCompletionHandler?(error)
        }
    }
    
    /**
        Search high schools names by text
     */
    func searchNYCHighSchools(searchText: String) {
        self.filteredNycHighSchools = self.nycHighSchools.filter { $0.schoolName.lowercased().contains(searchText.lowercased()) }
        self.delegate?.searchHighschoolsCompleted()
    }
}
