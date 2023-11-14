//
//  NetworkManager.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

protocol NetworkProtocol {
    func getData<T: Decodable>(urlStr: String, type: T.Type) async throws -> T
}

class NetworkManager: NetworkProtocol {
    func getData<T>(urlStr: String, type: T.Type) async throws -> T where T : Decodable {
        guard let url = URL(string: urlStr) else { throw NetworkError.badUrlError }
        var rawData: Data

        do {
            let (gotData, res) = try await URLSession.shared.data(for: URLRequest(url: url))
            rawData = gotData
            
            if let response = res as? HTTPURLResponse,
                   response.statusCode == 500 {
                throw NetworkError.serverError
            }
        } catch {
            throw NetworkError.unknownError
        }
        
        do {
            return try JSONDecoder().decode(type.self, from: rawData)
        } catch {
            throw NetworkError.dataParsingError
        }        
    }
}
