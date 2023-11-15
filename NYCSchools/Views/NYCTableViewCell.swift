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
    
    private let graduationRateText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "90%"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let graduationRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Graduation Rate"
        label.font = UIFont.systemFont(ofSize: 10)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let graduationRateGroupView: UIView = {
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
        
        graduationRateGroupView.addSubview(graduationRateText)
        graduationRateGroupView.addSubview(graduationRateLabel)
        
        labelStackView.addArrangedSubview(namesGroupView)
        labelStackView.addArrangedSubview(graduationRateGroupView)
        
        contentView.addSubview(labelStackView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let stackViewConstraints = [
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        let namesViewConstraints = [
            namesGroupView.centerYAnchor.constraint(equalTo: labelStackView.topAnchor),
            namesGroupView.leadingAnchor.constraint(equalTo: labelStackView.leadingAnchor)
        ]
        
        let schoolNameLabelConstraints = [
            schoolNameLabel.topAnchor.constraint(equalTo: namesGroupView.topAnchor),
            schoolNameLabel.leadingAnchor.constraint(equalTo: namesGroupView.leadingAnchor),
            schoolNameLabel.trailingAnchor.constraint(equalTo: namesGroupView.trailingAnchor, constant: -100)
        ]
        
        let addressLabelConstraints = [
            addressLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 5)
        ]
        
        let graduationGroupViewConstraints = [
            graduationRateGroupView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor)
        ]
        
        let graduationRateTextConstraints = [
            graduationRateText.topAnchor.constraint(equalTo: graduationRateGroupView.topAnchor),
            graduationRateText.trailingAnchor.constraint(equalTo: graduationRateGroupView.trailingAnchor)
        ]
        
        let graduationRateLabelConstraints = [
            graduationRateLabel.topAnchor.constraint(equalTo: graduationRateText.bottomAnchor, constant: 5),
            graduationRateLabel.trailingAnchor.constraint(equalTo: graduationRateGroupView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(namesViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(schoolNameLabelConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
        NSLayoutConstraint.activate(graduationGroupViewConstraints)
        NSLayoutConstraint.activate(graduationRateTextConstraints)
        NSLayoutConstraint.activate(graduationRateLabelConstraints)
    }

    func configure(nycSchool: NYCSchool) {
        self.schoolNameLabel.text = nycSchool.schoolName
        self.addressLabel.text = nycSchool.address
        self.graduationRateText.text = nycSchool.graduationRate > 0 ? nycSchool.graduationRate.toPercentageStr(decimalPlaces: 2) : "No Data"
    }
}
