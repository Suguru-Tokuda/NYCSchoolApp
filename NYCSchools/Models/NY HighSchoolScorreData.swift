//
//  HighSchoolScorreData.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import Foundation

struct NY HighSchoolScorreData: Decodable {
    let id: String
    let schoolName: String
    let numOfSatTestTakers: Int
    let satMathAvgScore: Int
    let satWritingAvgScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}
