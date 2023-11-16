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
    var orderKey: String = "graduation_rate"
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
                let schools = try await nycSchoolService?.getNYCSchools(limit: limit, offset: currentOffset, order: orderKey)
                
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
    
    /**
        Search high schools names by text
     */
    func searchNYCSchools(searchText: String) {
        self.filteredNycSchools = self.nycSchools.filter { $0.schoolName.lowercased().contains(searchText.lowercased()) }
        self.delegate?.searchSchoolsCompleted()
    }
}
