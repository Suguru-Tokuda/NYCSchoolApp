//
//  NYCSchoolScorreData.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import Foundation

struct NYCSchoolScorreData: Decodable {
    let id: String
    let schoolName: String
    let numOfSatTestTakers: Int
    let satCriticalReadingAvgScore: Int
    let satMathAvgScore: Int
    let satWritingAvgScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.schoolName = try container.decode(String.self, forKey: .schoolName)
        self.numOfSatTestTakers = Int(try container.decode(String.self, forKey: .numOfSatTestTakers)) ?? 0
        self.satCriticalReadingAvgScore = Int(try container.decode(String.self, forKey: .satCriticalReadingAvgScore)) ?? 0
        self.satMathAvgScore = Int(try container.decode(String.self, forKey: .satMathAvgScore)) ?? 0
        self.satWritingAvgScore = Int(try container.decode(String.self, forKey: .satWritingAvgScore)) ?? 0
    }
}
