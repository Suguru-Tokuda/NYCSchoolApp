//
//  NYCHighSchoolService.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

class NYCHighSchoolService {
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getAllNYCHighSchools(urlStr: String = Constants.nycHighSchoolEndpoint) async throws -> [NYCHighSchool] {
        do {
            return try await networkManager.getData(urlStr: urlStr, type: [NYCHighSchool].self)
        } catch {
            throw error
        }
    }
    
    func getNYCHighSchools(limit: Int, offset: Int, order: String, urlStr: String = Constants.nycHighSchoolEndpoint) async throws -> [NYCHighSchool] {
        do {
            return try await networkManager.getData(urlStr: "\(urlStr)?$limit=\(limit)&$offset=\(offset)&$order=\(order)", type: [NYCHighSchool].self)
        } catch {
            throw error
        }
    }
    
    func getNYCHighSchoolScore(id: String, urlStr: String = Constants.satDataEndpoint) async throws -> NYCHighSchoolScorreData? {
        do {
            let res = try await networkManager.getData(urlStr: "\(urlStr)?$where=dbn = \"\(id)\"", type: [NYCHighSchoolScorreData].self)
            return res.first
        } catch {
            throw error
        }
    }
}
