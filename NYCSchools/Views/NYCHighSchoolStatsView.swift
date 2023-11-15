//
//  NYCHighSchoolStatsView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/15/23.
//

import UIKit

class NYCHighSchoolStatsView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension NYCHighSchoolStatsView {
    private func setupUI() {
        self.addSubview(stackView)
    }
    
    func configure(school: NYCHighSchool) {
        // remove subviews first
        stackView.subviews.forEach { stackView.removeArrangedSubview($0) }
        
        let totalStudents = NYCHighSchoolScoreView()
        let attendanceRate = NYCHighSchoolScoreView()
        let graduationRate = NYCHighSchoolScoreView()
        let collegeCareerRate = NYCHighSchoolScoreView()
        
        totalStudents.configure(scoreTextStr: String(school.totalStudents), labelText: "Total Students")
        attendanceRate.configure(scoreTextStr: school.attendanceRate.toPercentageStr(decimalPlaces: 0), labelText: "Attendance Rate")
        graduationRate.configure(scoreTextStr: school.graduationRate.toPercentageStr(decimalPlaces: 0), labelText: "Graduation Rate")
        collegeCareerRate.configure(scoreTextStr: school.collegeCareerRate.toPercentageStr(decimalPlaces: 0), labelText: "College Career Rate")
        
        let subviews: [NYCHighSchoolScoreView] = [
            totalStudents,
            attendanceRate,
            graduationRate,
            collegeCareerRate
        ]
        
        let width = self.bounds.size.width / CGFloat(subviews.count)
        
        subviews.forEach { subview in
            subview.widthAnchor.constraint(equalToConstant: width).isActive = true
            stackView.addArrangedSubview(subview)
        }
    }
}
