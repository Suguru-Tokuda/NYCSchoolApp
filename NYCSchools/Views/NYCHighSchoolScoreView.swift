//
//  NYCHighSchoolScoreView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit

class NYCHighSchoolScoreView: UIView {
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var scoreText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
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
        stackView.addArrangedSubview(scoreText)
        stackView.addArrangedSubview(scoreLabel)
        self.addSubview(stackView)
        
        applyConstraints()        
    }
    
    private func applyConstraints() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ]
        
        let scoreTextConstraints = [
            scoreText.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scoreText.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ]
        
        let scoreLabelConstraints = [
            scoreLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints + scoreTextConstraints + scoreLabelConstraints)
    }
    
    func configure(score: Int, labelText: String) {
        scoreText.text = String(score)
        scoreLabel.text = labelText
    }
}
