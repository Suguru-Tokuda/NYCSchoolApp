//
//  NYCHighSchoolScoreView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit

class NYCHighSchoolScoreView: UIView {   
    private let scoreText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // Called when reconstituded from Nib
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension NYCHighSchoolScoreView {
    private func setupUI() {
        addSubview(scoreText)
        addSubview(scoreLabel)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let scoreTextConstraints = [
            scoreText.topAnchor.constraint(equalTo: topAnchor),
            scoreText.leadingAnchor.constraint(equalTo: leadingAnchor),
            scoreText.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        let scoreLabelConstraints = [
            scoreLabel.topAnchor.constraint(equalTo: scoreText.bottomAnchor, constant: 5),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(scoreTextConstraints)
        NSLayoutConstraint.activate(scoreLabelConstraints)
    }
    
    func configure(scoreTextStr: String, labelText: String) {
        scoreText.text = scoreTextStr
        scoreLabel.text = labelText
    }
}
