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
    
    func getNYCSchools(limit: Int, offset: Int, order: String, urlStr: String = Constants.nycSchoolEndpoint) async throws -> [NYCSchool] {
        do {
            return try await networkManager.getData(urlStr: "\(urlStr)?$limit=\(limit)&$offset=\(offset)&$order=\(order)", type: [NYCSchool].self)
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
