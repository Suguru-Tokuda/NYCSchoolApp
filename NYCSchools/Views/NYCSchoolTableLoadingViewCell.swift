//
//  NYCSchoolTableLoadingViewCell.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/18/23.
//

import UIKit

class NYCSchoolTableLoadingViewCell: UITableViewCell {
    static let identifier = "NYCSchoolTableLoadingViewCell"
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.style = .medium
        
        return spinner
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier reusableIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reusableIdentifier)
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

extension NYCSchoolTableLoadingViewCell {
    func setupUI() {
        contentView.addSubview(spinner)
        spinner.startAnimating()
        applyConstraints()
    }
    
    private func applyConstraints() {
        let spinnerConstraints = [
            spinner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            spinner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(spinnerConstraints)
    }
}
