//
//  NYCHighSchoolDetailView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import UIKit

class NYCHighSchoolDetailView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreLableGroup: NYCHighSchoolScoreGroupView = {
        let groupView = NYCHighSchoolScoreGroupView()
        groupView.translatesAutoresizingMaskIntoConstraints = false
        return groupView
    }()
    
    let overviewParagraph: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension NYCHighSchoolDetailView {
    private func setupUI() {
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(schoolNameLabel)
        stackView.addArrangedSubview(scoreLableGroup)
        stackView.addArrangedSubview(overviewParagraph)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
        ]
        
        let scrollViewContainerConstraints = [
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        let scoreLableGroupConstraints = [
            scoreLableGroup.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scoreLableGroup.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scoreLableGroup.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(scrollViewContainerConstraints)
        NSLayoutConstraint.activate(scoreLableGroupConstraints)
    }
}

extension NYCHighSchoolDetailView {
    func configure(school: NYCHighSchool, scoreData: NYCHighSchoolScorreData) {
        self.schoolNameLabel.text = school.schoolName
        self.overviewParagraph.text = school.overviewParaph
        self.scoreLableGroup.configure(scoreData: scoreData)
    }
}
