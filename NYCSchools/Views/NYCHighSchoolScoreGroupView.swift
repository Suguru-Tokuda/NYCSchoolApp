//
//  NYCHighSchoolScoreGroupView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit

class NYCHighSchoolScoreGroupView: UIView {
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
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

extension NYCHighSchoolScoreGroupView {
    private func setupUI() {
        self.addSubview(stackView)
    }
        
    func configure(scoreData: NYCHighSchoolScorreData) {
        // remove subviews first
        stackView.subviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
        }
            
        let testTakerScoreView = NYCHighSchoolScoreView()
        let criticalScoreView = NYCHighSchoolScoreView()
        let mathScoreView = NYCHighSchoolScoreView()
        let writingScoreView = NYCHighSchoolScoreView()
        
        testTakerScoreView.configure(score: scoreData.numOfSatTestTakers, labelText: "SAT Takers")
        criticalScoreView.configure(score: scoreData.satCriticalReadingAvgScore, labelText: "AVG Critical Reading")
        mathScoreView.configure(score: scoreData.satMathAvgScore, labelText: "AVG Math")
        writingScoreView.configure(score: scoreData.satWritingAvgScore, labelText: "AVG Writing")
        
        let subviews = [
            testTakerScoreView,
            criticalScoreView,
            mathScoreView,
            writingScoreView
        ]
        
        let width = self.bounds.size.width / 4
        
        subviews.forEach { subview in
            subview.widthAnchor.constraint(equalToConstant: width).isActive = true
            stackView.addArrangedSubview(subview)
        }
    }
}
