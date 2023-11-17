//
//  NYCTableViewCell.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import UIKit

class NYCTableViewCell: UITableViewCell {
    static let identifier = "NYCTableViewCell"
    
    private let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let namesGroupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rateText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rateTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collegeCareerRateGroupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension NYCTableViewCell {
    private func setupUI() {
        namesGroupView.addSubview(schoolNameLabel)
        namesGroupView.addSubview(addressLabel)
        
        collegeCareerRateGroupView.addSubview(rateText)
        collegeCareerRateGroupView.addSubview(rateTextLabel)
        
        contentView.addSubview(labelStackView)
        
        labelStackView.addArrangedSubview(namesGroupView)
        labelStackView.addArrangedSubview(collegeCareerRateGroupView)
        
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let padding: CGFloat = 10
        
        let stackViewConstraints = [
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ]
        
        let namesViewConstraints = [
            namesGroupView.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            namesGroupView.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor),
            namesGroupView.leadingAnchor.constraint(equalTo: labelStackView.leadingAnchor),
            namesGroupView.trailingAnchor.constraint(equalTo: collegeCareerRateGroupView.leadingAnchor, constant: -10)
        ]
        
        let schoolNameLabelConstraints = [
            schoolNameLabel.topAnchor.constraint(equalTo: namesGroupView.topAnchor),
            schoolNameLabel.leadingAnchor.constraint(equalTo: namesGroupView.leadingAnchor),
            schoolNameLabel.trailingAnchor.constraint(equalTo: namesGroupView.trailingAnchor, constant: -20)
        ]
        
        schoolNameLabel.contentHuggingPriority(for: .vertical)
        schoolNameLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        
        let addressLabelConstraints = [
            addressLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 5),
            addressLabel.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor)
        ]
        
        let graduationGroupViewConstraints = [
            collegeCareerRateGroupView.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            collegeCareerRateGroupView.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor),
            collegeCareerRateGroupView.widthAnchor.constraint(equalToConstant: 75),
            collegeCareerRateGroupView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor)
        ]
        
        let graduationRateTextConstraints = [
            rateText.topAnchor.constraint(equalTo: collegeCareerRateGroupView.topAnchor),
            rateText.trailingAnchor.constraint(equalTo: collegeCareerRateGroupView.trailingAnchor)
        ]
        
        let graduationRateLabelConstraints = [
            rateTextLabel.topAnchor.constraint(equalTo: rateText.bottomAnchor, constant: 5),
            rateTextLabel.trailingAnchor.constraint(equalTo: collegeCareerRateGroupView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(namesViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(schoolNameLabelConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
        NSLayoutConstraint.activate(graduationGroupViewConstraints)
        NSLayoutConstraint.activate(graduationRateTextConstraints)
        NSLayoutConstraint.activate(graduationRateLabelConstraints)
    }

    func configure(nycSchool: NYCSchool, sortKey: NYCSchoolSortKey) {
        self.schoolNameLabel.text = nycSchool.schoolName
        self.addressLabel.text = nycSchool.address
        
        switch sortKey {
        case .attendanceRate:
            self.rateTextLabel.text = sortKey.rawValue
            self.rateText.text = nycSchool.attendanceRate > 0 ? nycSchool.attendanceRate.toPercentageStr(decimalPlaces: 2) : "No Data"
        case .collegeCareerRate:
            self.rateTextLabel.text = sortKey.rawValue
            self.rateText.text = nycSchool.collegeCareerRate > 0 ? nycSchool.collegeCareerRate.toPercentageStr(decimalPlaces: 2) : "No Data"
        case .graduationRate:
            self.rateTextLabel.text = sortKey.rawValue
            self.rateText.text = nycSchool.graduationRate > 0 ? nycSchool.graduationRate.toPercentageStr(decimalPlaces: 2) : "No Data"
        case .totalStudents:
            self.rateTextLabel.text = sortKey.rawValue
            self.rateText.text = nycSchool.totalStudents > 0 ? String(nycSchool.totalStudents) : "No Data"
        default:
            self.rateTextLabel.text = NYCSchoolSortKey.graduationRate.rawValue
            self.rateText.text = nycSchool.graduationRate > 0 ? nycSchool.graduationRate.toPercentageStr(decimalPlaces: 2) : "No Data"
        }
    }
}
