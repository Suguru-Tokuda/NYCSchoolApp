//
//  NYCSchoolService.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

class NYCSchoolService {
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getAllNYCSchools(urlStr: String = Constants.nycSchoolEndpoint) async throws -> [NYCSchool] {
        do {
            return try await networkManager.getData(urlStr: urlStr, type: [NYCSchool].self)
        } catch {
            throw error
        }
    }
    
    func getNYCSchools(limit: Int, offset: Int, sortKey: NYCSchoolSortKey, sortOrder: SortOrder, urlStr: String = Constants.nycSchoolEndpoint) async throws -> [NYCSchool] {
        do {
            return try await networkManager.getData(urlStr: "\(urlStr)?$limit=\(limit)&$offset=\(offset)&$order=\(sortKey.getAPIFieldName()) \(sortOrder.getSortOrderStr())&$where=\(sortKey.getAPIFieldName()) IS NOT NULL", type: [NYCSchool].self)
        } catch {
            throw error
        }
    }
    
    func getNYCSchoolScore(id: String, urlStr: String = Constants.satDataEndpoint) async throws -> NYCSchoolScorreData? {
        do {
            let res = try await networkManager.getData(urlStr: "\(urlStr)?$where=dbn = \"\(id)\"", type: [NYCSchoolScorreData].self)
            return res.first
        } catch {
            throw error
        }
    }
}
