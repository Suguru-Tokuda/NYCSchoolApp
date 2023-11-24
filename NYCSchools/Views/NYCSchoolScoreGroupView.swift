//
//  NYCSchoolScoreGroupView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit

class NYCSchoolScoreGroupView: UIView {
    private lazy var stackView: UIStackView = {
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

extension NYCSchoolScoreGroupView {
    private func setupUI() {
        self.addSubview(stackView)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
    }
        
    func configure(scoreData: NYCSchoolScorreData) {
        // remove subviews first
        stackView.subviews.forEach { stackView.removeArrangedSubview($0) }
            
        let testTakerScoreView = NYCSchoolScoreView()
        let criticalScoreView = NYCSchoolScoreView()
        let mathScoreView = NYCSchoolScoreView()
        let writingScoreView = NYCSchoolScoreView()
        
        testTakerScoreView.configure(scoreTextStr: String(scoreData.numOfSatTestTakers), labelText: "SAT Takers")
        criticalScoreView.configure(scoreTextStr: String(scoreData.satCriticalReadingAvgScore), labelText: "AVG Critical Reading")
        mathScoreView.configure(scoreTextStr: String(scoreData.satMathAvgScore), labelText: "AVG Math")
        writingScoreView.configure(scoreTextStr: String(scoreData.satWritingAvgScore), labelText: "AVG Writing")
        
        let subviews: [NYCSchoolScoreView] = [
            testTakerScoreView,
            criticalScoreView,
            mathScoreView,
            writingScoreView
        ]
        
        subviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }
}
