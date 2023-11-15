//
//  NYCSchoolDetailView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import UIKit

class NYCSchoolDetailView: UIView {
    weak var delegate: NYCSchoolHomepageURLTapDelegate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hoursView: HoursView = {
        let hoursView = HoursView()
        hoursView.translatesAutoresizingMaskIntoConstraints = false
        return hoursView
    }()
    
    private let urlView: HomepageURLView = {
        let urlView = HomepageURLView()
        urlView.translatesAutoresizingMaskIntoConstraints = false
        return urlView
    }()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Statistics"
        return label
    }()
    
    private let statsView: NYCSchoolStatsView = {
        let statsView = NYCSchoolStatsView()
        statsView.translatesAutoresizingMaskIntoConstraints = false
        return statsView
    }()
    
    private let scoreLabelGroup: NYCSchoolScoreGroupView = {
        let groupView = NYCSchoolScoreGroupView()
        groupView.translatesAutoresizingMaskIntoConstraints = false
        return groupView
    }()
    
    private let overviewParagraphLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        return label
    }()
    
    private let overviewParagraph: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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

extension NYCSchoolDetailView {
    private func setupUI() {
        backgroundColor = .systemBackground

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(schoolNameLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(hoursView)
        stackView.addArrangedSubview(urlView)
        stackView.addArrangedSubview(statsLabel)
        stackView.addArrangedSubview(scoreLabelGroup)
        stackView.addArrangedSubview(statsView)
        stackView.addArrangedSubview(overviewParagraphLabel)
        stackView.addArrangedSubview(overviewParagraph)
        
        urlView.linkTapped = { urlStr in
            self.delegate?.nycSchoolHomepageURLTap(urlStr: urlStr)            
        }
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        
        let padding: CGFloat = 10
        
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -padding * 2)
        ]
        
        let stackViewContainerConstraints = [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let hoursViewConstraints = [
            hoursView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hoursView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hoursView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let urlViewConstraints = [
            urlView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            urlView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            urlView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let scoreLableGroupConstraints = [
            scoreLabelGroup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scoreLabelGroup.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scoreLabelGroup.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let statsViewConstraints = [
            statsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            statsView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(stackViewContainerConstraints)
        NSLayoutConstraint.activate(hoursViewConstraints)
        NSLayoutConstraint.activate(urlViewConstraints)
        NSLayoutConstraint.activate(scoreLableGroupConstraints)
        NSLayoutConstraint.activate(statsViewConstraints)
    }
}

extension NYCSchoolDetailView {
    func configure(school: NYCSchool, scoreData: NYCSchoolScorreData) {
        schoolNameLabel.text = school.schoolName
        addressLabel.text = school.address
        if !school.startTime.isEmpty && !school.endTime.isEmpty {
            hoursView.configure(startTime: school.startTime, endTime: school.endTime)
        } else {
            hoursView.isHidden = true
        }
        
        overviewParagraph.text = school.overviewParaph
        
        if scoreData.numOfSatTestTakers != 0 || scoreData.satCriticalReadingAvgScore != 0 || scoreData.satMathAvgScore != 0 || scoreData.satWritingAvgScore != 0 {
            scoreLabelGroup.configure(scoreData: scoreData)
        } else {
            scoreLabelGroup.isHidden = true
        }
        
        if school.totalStudents != 0 || school.attendanceRate != 0 || school.graduationRate != 0 || school.collegeCareerRate != 0 {
            statsView.configure(school: school)
        } else {
            statsView.isHidden = true
        }
        
        if scoreLabelGroup.isHidden && statsView.isHidden {
            statsLabel.isHidden = true
        }
        
        if !school.website.isEmpty {
            urlView.configure(urlStr: school.website)
        } else {
            urlView.isHidden = true
        }
        
        // add academic opportunities
        if !school.acamidecOpportunties.isEmpty {
            let academicOpportunitiesView = TitleBulletPointsView()
            academicOpportunitiesView.translatesAutoresizingMaskIntoConstraints = false
            academicOpportunitiesView.configure(title: "Academic Opportunities", contents: school.acamidecOpportunties)
            academicOpportunitiesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
            stackView.addArrangedSubview(academicOpportunitiesView)
        }
        
        // add programs
        if !school.programs.isEmpty {
            let programsView = TitleBulletPointsView()
            programsView.configure(title: "Programs", contents: school.programs)
            programsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
            stackView.addArrangedSubview(programsView)
        }
        
        // add interests
        if !school.interests.isEmpty {
            let interestsView = TitleBulletPointsView()
            interestsView.configure(title: "Interests", contents: school.interests)
            interestsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            stackView.addArrangedSubview(interestsView)
        }
        
        if !school.methods.isEmpty {
            let methodsView = TitleBulletPointsView()
            methodsView.configure(title: "Methods", contents: school.methods)
            methodsView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            stackView.addArrangedSubview(methodsView)
        }
    }
}
