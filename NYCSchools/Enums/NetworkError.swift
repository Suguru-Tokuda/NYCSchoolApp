//
//  NetworkError.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

enum NetworkError: String, Error {
    case badUrlError,
         noDataFoundError,
         dataParsingError,
         serverError,
         unknownError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badUrlError:
            return NSLocalizedString("Bad URL Error. Please make sure the URL is valid.", comment: self.rawValue)
        case .noDataFoundError:
            return NSLocalizedString("No data found.", comment: self.rawValue)
        case .dataParsingError:
            return NSLocalizedString("Error in parsing the json data.", comment: self.rawValue)
        case .serverError:
            return NSLocalizedString("Server error.", comment: self.rawValue)
        case .unknownError:
            return NSLocalizedString("Unknown error.", comment: self.rawValue)
        }
    }
}
