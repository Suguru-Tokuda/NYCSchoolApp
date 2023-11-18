//
//  NYCSchoolTableLoadingViewCell.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/18/23.
//

import UIKit

class NYCSchoolTableLoadingViewCell: UITableViewCell {
    static let identifier = "NYCSchoolTableLoadingViewCell"
    
    private var spinner: UIActivityIndicatorView = {
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
        applyConstraints()
    }
    
    private func applyConstraints() {
        spinner.startAnimating()
        spinner.center = center
    }
}
