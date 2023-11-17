//
//  NYCSchoolOrderEnum.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/16/23.
//

import Foundation

enum NYCSchoolSortKey: String, CaseIterable {
    case schoolName = "School Name",
         totalStudents = "Total Students",
         attendanceRate = "Attendance Rate",
         graduationRate = "Graduation Rate",
         collegeCareerRate = "College Career Rate"
    
    // get the name used in api query.
    func getAPIFieldName() -> String {
        switch self {
        case .schoolName:
            return "school_name"
        case .totalStudents:
            return "total_students"
        case .attendanceRate:
            return "attendance_rate"
        case .graduationRate:
            return "graduation_rate"
        case .collegeCareerRate:
            return "college_career_rate"
        }
    }
}
