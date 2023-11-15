//
//  NYCSchoolStatsView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/15/23.
//

import UIKit

class NYCSchoolStatsView: UIView {
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

extension NYCSchoolStatsView {
    private func setupUI() {
        self.addSubview(stackView)
    }
    
    func configure(school: NYCSchool) {
        // remove subviews first
        stackView.subviews.forEach { stackView.removeArrangedSubview($0) }
        
        let totalStudents = NYCSchoolScoreView()
        let attendanceRate = NYCSchoolScoreView()
        let graduationRate = NYCSchoolScoreView()
        let collegeCareerRate = NYCSchoolScoreView()
        
        totalStudents.configure(scoreTextStr: String(school.totalStudents), labelText: "Total Students")
        attendanceRate.configure(scoreTextStr: school.attendanceRate.toPercentageStr(decimalPlaces: 0), labelText: "Attendance Rate")
        graduationRate.configure(scoreTextStr: school.graduationRate.toPercentageStr(decimalPlaces: 0), labelText: "Graduation Rate")
        collegeCareerRate.configure(scoreTextStr: school.collegeCareerRate.toPercentageStr(decimalPlaces: 0), labelText: "College Career Rate")
        
        let subviews: [NYCSchoolScoreView] = [
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
