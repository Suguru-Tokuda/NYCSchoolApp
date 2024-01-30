//
//  NetworkManager.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func getData<T: Decodable>(urlStr: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func getData<T: Decodable>(urlStr: String, type: T.Type) async throws -> T
    func getData<T: Decodable>(urlStr: String, type: T.Type) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkProtocol {
    func getData<T: Decodable>(urlStr: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlStr) else {
            completion(.failure(NetworkError.badUrlError))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, res, _ in
            if let data {
                if let response = res as? HTTPURLResponse {
                    if response.statusCode == 500 {
                        completion(.failure(NetworkError.serverError))
                    }
                }
                
                do {
                    let parsedData = try JSONDecoder().decode(type.self, from: data)
                    completion(.success(parsedData))
                } catch {
                    completion(.failure(NetworkError.dataParsingError))
                }
            } else {
                completion(.failure(NetworkError.noDataFoundError))
            }
        }.resume()
    }
    
    func getData<T: Decodable>(urlStr: String, type: T.Type) async throws -> T {
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
    
    func getData<T: Decodable>(urlStr: String, type: T.Type) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: urlStr)!)
            .tryMap { val in
                if let response = val.response as? HTTPURLResponse,
                   response.statusCode == 500 {
                    throw NetworkError.serverError
                }
                
                return val.data
            }
            .decode(type: type.self, decoder: JSONDecoder())
            .mapError({ error in
                switch error {
                case is Swift.DecodingError:
                    return NetworkError.dataParsingError
                default:
                    return NetworkError.unknownError
                }
            })
            .eraseToAnyPublisher()
    }
}
