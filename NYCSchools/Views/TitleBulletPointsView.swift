//
//  TitleBulletPointsView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/15/23.
//

import UIKit

class TitleBulletPointsView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func getContentLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // called if Storyboard is used
    /**
     https://stackoverflow.com/questions/52239550/when-is-required-initcoder-adecoder-nscoder-called-on-a-uiview-or-uiviewco
     */
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleBulletPointsView {
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(listStackView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        let listStackViewCostraints = [
            listStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            listStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(listStackViewCostraints)
    }
    
    // Set title & add contents
    func configure(title: String, contents: [String]) {
        self.titleLabel.text = title
        
        // add contents
        listStackView.subviews.forEach { listStackView.removeArrangedSubview($0) }
        contents.forEach { listStackView.addArrangedSubview(getContentLabel(text: "\u{2022} \($0)"))}
//        
//        let height: CGFloat  = 50 * CGFloat(contents.count)
//        
//        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
