//
//  NYCSchoolDetailView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import UIKit

class NYCSchoolDetailView: UIView {
    weak var delegate: NYCSchoolHomepageURLTapDelegate?
    
    private lazy var scrollView: UIScrollView! = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var schoolNameLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var hoursView: HoursView! = {
        let hoursView = HoursView()
        hoursView.translatesAutoresizingMaskIntoConstraints = false
        return hoursView
    }()
    
    private lazy var urlView: HomepageURLView! = {
        let urlView = HomepageURLView()
        urlView.translatesAutoresizingMaskIntoConstraints = false
        return urlView
    }()
    
    private lazy var statsLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Statistics"
        return label
    }()
    
    private lazy var statsView: NYCSchoolStatsView! = {
        let statsView = NYCSchoolStatsView()
        statsView.translatesAutoresizingMaskIntoConstraints = false
        return statsView
    }()
    
    private lazy var scoreLabelGroup: NYCSchoolScoreGroupView! = {
        let groupView = NYCSchoolScoreGroupView()
        groupView.translatesAutoresizingMaskIntoConstraints = false
        return groupView
    }()
    
    private lazy var overviewParagraphLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        return label
    }()
    
    private lazy var overviewParagraph: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var academicOpportunitiesView: TitleBulletPointsView! = {
        let view = TitleBulletPointsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var programsView: TitleBulletPointsView! = {
        let view = TitleBulletPointsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var interestsView: TitleBulletPointsView! = {
        let view = TitleBulletPointsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var methodsView: TitleBulletPointsView! = {
        let view = TitleBulletPointsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        stackView.addArrangedSubview(academicOpportunitiesView)
        stackView.addArrangedSubview(programsView)
        stackView.addArrangedSubview(interestsView)
        stackView.addArrangedSubview(methodsView)
        
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
        
        let homepageViewConstraints = [
            urlView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            urlView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        let scoreLableGroupConstraints = [
            scoreLabelGroup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scoreLabelGroup.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        let statsViewConstraints = [
            statsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(stackViewContainerConstraints)
        NSLayoutConstraint.activate(homepageViewConstraints)
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
            academicOpportunitiesView.configure(title: "Academic Opportunities", contents: school.acamidecOpportunties)
        } else {
            academicOpportunitiesView.isHidden = true
        }
        
        // add programs
        if !school.programs.isEmpty {
            programsView.configure(title: "Programs", contents: school.programs)
        } else {
            programsView.isHidden = true
        }
        
        // add interests
        if !school.interests.isEmpty {
            interestsView.configure(title: "Interests", contents: school.interests)
        } else {
            interestsView.isHidden = true
        }
        
        if !school.methods.isEmpty {
            methodsView.configure(title: "Methods", contents: school.methods)
        } else {
            methodsView.isHidden = true
        }
    }
    
    func setUrlViewIsHidden(isHidden: Bool) {
        urlView.isHidden = isHidden
    }
}
