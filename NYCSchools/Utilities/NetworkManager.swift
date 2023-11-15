//
//  NetworkManager.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func getData<T: Decodable>(urlStr: String, type: T.Type) async throws -> T
}

class NetworkManager: NetworkProtocol {
    func getData<T>(urlStr: String, type: T.Type) async throws -> T where T : Decodable {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(urlStr)
                .responseData { res in
                    switch res.result {
                    case .success(let data):
                        do {
                            let processedData = try JSONDecoder().decode(type.self, from: data)
                            continuation.resume(returning: processedData)
                        } catch {
                            continuation.resume(throwing: NetworkError.dataParsingError)
                        }
                    case .failure(_):
                        continuation.resume(throwing: NetworkError.serverError)
                    }
                }
        }
    }
}
